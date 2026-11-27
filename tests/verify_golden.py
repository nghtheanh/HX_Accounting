from decimal import Decimal as D
from pathlib import Path
import json
x=json.loads(Path(__file__).with_name('golden.json').read_text())
a=x['inventory']; q=D(a['opening_qty'])+D(a['receipt_qty']); v=D(a['opening_qty'])*D(a['opening_price'])+D(a['receipt_qty'])*D(a['receipt_price']); avg=v/q; issue=avg*D(a['issue_qty']); assert avg==D(a['expected_average']) and issue==D(a['expected_issue']) and v-issue==D(a['expected_remaining'])
a=x['allocation']; assert sum(map(D,a['allocated']))==D(a['payment']); assert all(D(y)<=D(z) for y,z in zip(a['allocated'],a['debts'])); assert sum(map(D,a['debts']))-D(a['payment'])==D(a['expected_remaining'])
a=x['costing']; c=D(a['wip_open'])+sum(map(D,a['costs']))-D(a['wip_close']); assert c==D(a['expected_cogs']) and c/D(a['quantity'])==D(a['expected_unit']) and D(a['revenue'])-c==D(a['expected_gross'])
a=x['payroll']; g=D(a['base'])+D(a['piece_qty'])*D(a['piece_rate'])+D(a['allowance']); assert g==D(a['expected_gross']) and g-D(a['advance'])-D(a['deduction'])==D(a['expected_payable'])
a=x['journal']['lines']; assert sum(D(r['debit']) for r in a)==sum(D(r['credit']) for r in a)
a=x['mts']; assert D(a['blank_qty'])*D(a['blank_unit'])+D(a['finishing'])==D(a['expected_total'])
print('PASS: 6 independent golden arithmetic cases (not application tests)')
