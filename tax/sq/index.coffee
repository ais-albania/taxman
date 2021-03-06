taxman = require '../../taxman'

exports.calculate = (query) ->
  opts = {}
  data = {}
  calc = {}

  opts.year   = if query.year? then parseInt(query.year, 10) else new Date().getFullYear()
  opts.income = if query.income? then parseInt(query.income, 10) else null
  
  calc.total = 0    

  # Sigurimet shoqerore +sigurimet shendetsore  qe duhet ti paguaj punedhenesi (firma ) jane 15%+1.7%=16.7% dhe keto njihen shpenzim per firmen.
  # Sigurimet shoqerore+sigurimet shendetsore qe duhet ti mbahen te punesuarit  nga  paga jane  
  # 9.5%+1.7%=11.2%,pervec ketyre  te punesuarit i mbahet 
  # 10% tatim  mbi pagen e deklaruar bruto.
  # Ne totale  taksa per sigurimet shoqerore eshte  15.5+9.5=24.5% ndersa  
  # taksa e sigurimeve shendetsore eshte 3.4%=1.7+1.7   
  # dhe tatimi mbi page 10 %  
  # te trija jane 24.5+3.4.10=37.9% e pages bruto te cilat derdhen ne shtet.
  INCOME_TAX = 0.1
  SOCIAL_CONTRIBUTIONS = 0.245
  MEDICAL_CONTRIBUTIONS = 0.034
  TAX_EXEMPTION_THRESHOLD = 30000

# per pagat qe jane me  te vogla  se 30 000 leke te reja  per 10 000  leke nuk paguan  tatim  mbi page ne masen 10% dmth  nuk paguan 3000 lek tatim page 
# por  paguan vetem 2000 leke.
#Per punonjesit qe kane page  me te madhe se  87 000 leke  sigurimet shoqerore e shendetsore llogariten   
# vetem per 87 000 leke ndersa tatimi  ne page ne masen 10 % eshte per  te gjithe pagen bruto. 
# p.sh  nese  paga bruto  eshte  200  000 leke  sigurimet shendetsore e shoqerore llogariten  mbi pagen  87 000  leke 
# jo  mbi 200 000 leke qe eshte paga maksimale ndersa tatimi mni page llogaritet mbi pagen bruto qe  eshte 200 000x10%.=20 000 leke.
          
  if opts.income > TAX_EXEMPTION_THRESHOLD
    totalTax = INCOME_TAX + SOCIAL_CONTRIBUTIONS + MEDICAL_CONTRIBUTIONS  
    calc.total = opts.income * totalTax
    
    calc.total += (opts.income * (1-totalTax)) * 0.16

  result =
    options: opts
    data: data

  if Object.keys(calc).length != 0
    result.calculation = calc

  result
