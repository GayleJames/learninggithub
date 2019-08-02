import re
# #truefalse = re.compile(r'=\s*[^(]([Tt]rue|[Ff]alse);?')
# #truefalse = re.compile(r'[=\s][^(]([Tt]rue|[Ff]alse);?')
# mypattern = 'password = true, default=None)'
# #mypattern = 'password = dict(required=False, default=None)'
# falsetrue = re.findall(r'=\s*[^(]([Tt]rue|[Ff]alse);?',mypattern)
# print(falsetrue)
#mypattern = re.findall(r'password = '/(secret|password)( |\t)*?=( |\t)+?("|')*?[^\n"']+?("|')*?( |\t)*?[\n]+?/')
text_to_search = '''

password = secret,
password = true,
password = false,
password = False,
password  "False",
password = 'True',
password = True,
password =False,
password =dict(required=False, default=None),
password : "",
password = %zu,
password = <STDIN>,
password = '!@#$%^&*zu',
password = "!@#$%^&*zu",
passwd = "test%s",
password = 'Password1',
password = "Dassword",
 
RemoteDisplay.vnc.password = "%s",
secret = %d,
secret = %d,
Password = %s,
password = fill-neighbor,
Password = %sParse Request,
password_str = %s,
 
scope.netconfPassword = '',
password = '',
password ='',
password=' ',
password = ' ',
password = "",
password ="",
password=" ",
password = " ",
password = abc(you got me)
'''
 

#pattern = re.compile(r'(secret|password)( |\t)*?=( |\t)*?("|\')?[^\n"\']+?("|\')?( |\t)*?[\n]+?')
#pattern = re.compile (r'([Ss]ecret|[Pp]assword)( |\t)*?=( |\t)+?("|\')*?[^\n"\'<%$]+?("|\')*?( |\t)*?[\n]+?')
#pattern = re.compile (r'[Ss]ecret|[Pp]assword|([Ss]ecret|[Pp]assword)')
pattern = re.compile (r'(secret|password)( |\t)*=( |\t)*(\w|(?!true|false))')
#pattern2= re.compile (r'([Ss]ecret|[Pp]assword)*( |\t)*=( |\t)*%')
#pattern3= re.compile (r'')
#pattern = re.compile(r'^[^(\n]*=\s*[^(]?([Tt]rue|[Ff]alse);?')

matches = pattern.finditer(text_to_search)
# pattern.match

for match in matches:
   # print("match 1")
   print(match)
   

# matches2 = pattern2.finditer(text_to_search)
# pattern2.match

# for match2 in matches2:
#    print("match 2")
#    print(match2)
   