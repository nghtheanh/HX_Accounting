-- PostgreSQL reference core; sandbox only. Extend with reviewed migrations.
BEGIN;
CREATE TABLE company(id uuid PRIMARY KEY, name text NOT NULL, production_enabled boolean NOT NULL DEFAULT false);
CREATE TABLE policy(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, version int NOT NULL, effective_date date NOT NULL, approved_at timestamptz, config jsonb NOT NULL, UNIQUE(company_id,version));
CREATE TABLE period(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, start_date date NOT NULL, end_date date NOT NULL CHECK(end_date>=start_date), locked boolean NOT NULL DEFAULT false, UNIQUE(company_id,start_date));
CREATE TABLE account(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, code text NOT NULL, name text NOT NULL, parent_id uuid REFERENCES account, UNIQUE(company_id,code));
CREATE TABLE party(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, code text NOT NULL, name text NOT NULL, UNIQUE(company_id,code));
CREATE TABLE document(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, number text NOT NULL, kind text NOT NULL, business_date date NOT NULL, status text NOT NULL CHECK(status IN ('draft','submitted','approved','rejected','posted')), version int NOT NULL DEFAULT 1, policy_id uuid REFERENCES policy, payload jsonb NOT NULL DEFAULT '{}', UNIQUE(company_id,number));
CREATE TABLE journal(id uuid PRIMARY KEY, document_id uuid NOT NULL REFERENCES document, period_id uuid NOT NULL REFERENCES period, reverses_id uuid UNIQUE REFERENCES journal, posted_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE journal_line(id uuid PRIMARY KEY, journal_id uuid NOT NULL REFERENCES journal, account_id uuid NOT NULL REFERENCES account, party_id uuid REFERENCES party, debit numeric(24,2) NOT NULL DEFAULT 0, credit numeric(24,2) NOT NULL DEFAULT 0, CHECK((debit>0 AND credit=0) OR (credit>0 AND debit=0)));
CREATE FUNCTION check_balance() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE jid uuid; BEGIN
 IF TG_TABLE_NAME='journal' THEN jid:=NEW.id; ELSE jid:=COALESCE(NEW.journal_id,OLD.journal_id); END IF;
 IF EXISTS(SELECT 1 FROM journal WHERE id=jid) AND (SELECT count(*)<2 OR COALESCE(sum(debit-credit),0)<>0 FROM journal_line WHERE journal_id=jid) THEN RAISE EXCEPTION 'Unbalanced journal %',jid; END IF; RETURN NULL; END $$;
CREATE CONSTRAINT TRIGGER journal_balance AFTER INSERT ON journal DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION check_balance();
CREATE CONSTRAINT TRIGGER line_balance AFTER INSERT ON journal_line DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION check_balance();
CREATE FUNCTION immutable_row() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN RAISE EXCEPTION 'Immutable ledger'; END $$;
CREATE TRIGGER journal_immutable BEFORE UPDATE OR DELETE ON journal FOR EACH ROW EXECUTE FUNCTION immutable_row();
CREATE TRIGGER line_immutable BEFORE UPDATE OR DELETE ON journal_line FOR EACH ROW EXECUTE FUNCTION immutable_row();
CREATE TABLE warehouse(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, code text NOT NULL, UNIQUE(company_id,code));
CREATE TABLE item(id uuid PRIMARY KEY, company_id uuid NOT NULL REFERENCES company, sku text NOT NULL, name text NOT NULL, color text, size text, uom text NOT NULL, UNIQUE(company_id,sku));
CREATE TABLE lot(id uuid PRIMARY KEY, item_id uuid NOT NULL REFERENCES item, code text NOT NULL, UNIQUE(item_id,code));
CREATE TABLE stock_pool(warehouse_id uuid REFERENCES warehouse,item_id uuid REFERENCES item, qty numeric(24,6) NOT NULL CHECK(qty>=0), value numeric(24,2) NOT NULL CHECK(value>=0), CHECK(qty<>0 OR value=0), PRIMARY KEY(warehouse_id,item_id));
CREATE TABLE lot_balance(warehouse_id uuid REFERENCES warehouse,lot_id uuid REFERENCES lot,qty numeric(24,6) NOT NULL CHECK(qty>=0),PRIMARY KEY(warehouse_id,lot_id));
CREATE TABLE stock_movement(id uuid PRIMARY KEY,document_id uuid NOT NULL REFERENCES document, warehouse_id uuid NOT NULL REFERENCES warehouse,item_id uuid NOT NULL REFERENCES item,lot_id uuid REFERENCES lot, sequence bigint GENERATED ALWAYS AS IDENTITY, qty_delta numeric(24,6) NOT NULL CHECK(qty_delta<>0),value_delta numeric(24,2) NOT NULL, source_id uuid REFERENCES stock_movement);
CREATE TABLE money_account(id uuid PRIMARY KEY,company_id uuid NOT NULL REFERENCES company,account_id uuid NOT NULL REFERENCES account,name text NOT NULL,kind text NOT NULL CHECK(kind IN ('cash','bank')));
CREATE TABLE payment(id uuid PRIMARY KEY,document_id uuid NOT NULL REFERENCES document,party_id uuid REFERENCES party,money_account_id uuid NOT NULL REFERENCES money_account,amount numeric(24,2) NOT NULL CHECK(amount>0),direction text NOT NULL CHECK(direction IN ('in','out')));
CREATE TABLE open_item(id uuid PRIMARY KEY,document_id uuid NOT NULL REFERENCES document,party_id uuid NOT NULL REFERENCES party,kind text NOT NULL CHECK(kind IN ('AR','AP','AR_ADVANCE','AP_ADVANCE')),amount numeric(24,2) NOT NULL CHECK(amount>0),due_date date);
CREATE TABLE allocation(id uuid PRIMARY KEY,payment_id uuid NOT NULL REFERENCES payment,open_item_id uuid NOT NULL REFERENCES open_item,amount numeric(24,2) NOT NULL CHECK(amount>0),allocated_date date NOT NULL);
CREATE TABLE bom_version(id uuid PRIMARY KEY,item_id uuid NOT NULL REFERENCES item,version int NOT NULL,approved_at timestamptz,UNIQUE(item_id,version));
CREATE TABLE bom_line(id uuid PRIMARY KEY,bom_id uuid NOT NULL REFERENCES bom_version,material_id uuid NOT NULL REFERENCES item,qty numeric(24,6) NOT NULL CHECK(qty>0),loss_rate numeric(9,6) NOT NULL DEFAULT 0 CHECK(loss_rate>=0));
CREATE TABLE production_order(id uuid PRIMARY KEY,company_id uuid NOT NULL REFERENCES company,code text NOT NULL,mode text NOT NULL CHECK(mode IN ('MTO','MTS')),bom_id uuid NOT NULL REFERENCES bom_version,planned_qty numeric(24,6) NOT NULL CHECK(planned_qty>0),UNIQUE(company_id,code));
CREATE TABLE cost_entry(id uuid PRIMARY KEY,production_id uuid NOT NULL REFERENCES production_order,document_id uuid NOT NULL REFERENCES document,kind text NOT NULL,amount numeric(24,2) NOT NULL);
CREATE TABLE approval(id uuid PRIMARY KEY,document_id uuid NOT NULL REFERENCES document,document_version int NOT NULL,actor_id uuid NOT NULL,decision text NOT NULL,rule_snapshot jsonb NOT NULL,created_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE audit(id uuid PRIMARY KEY,company_id uuid NOT NULL REFERENCES company,actor_id uuid,action text NOT NULL,entity_id uuid,details jsonb NOT NULL,created_at timestamptz NOT NULL DEFAULT now());
CREATE TABLE idempotency(company_id uuid REFERENCES company,action text,key text,payload_hash text NOT NULL,response jsonb,PRIMARY KEY(company_id,action,key));
CREATE TABLE outbox(id uuid PRIMARY KEY,company_id uuid NOT NULL REFERENCES company,event_type text NOT NULL,payload jsonb NOT NULL,created_at timestamptz NOT NULL DEFAULT now(),published_at timestamptz);
COMMIT;
-- REQUIRED before production: tenant composite FKs, strict posting procedure/roles (no late line inserts), period locking and policy gates, allocation aggregate checks with locks, lot/pool consistency, append-only subledgers/audit, full domain migrations and indexes. This is intentionally a reference schema, not a hardened deployment migration.
