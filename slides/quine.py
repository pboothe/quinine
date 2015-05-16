q = '"""'
s = """q = '{q}'
s = {q}{s}{q}
print s.format(q = q, s = s)"""
print s.format(q = q, s = s)
