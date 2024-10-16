# import requests 
# fname= open("Output_1.xlsx","w")
# r = requests.request(
#     method='get',
#     url="https://docs.logilite.com/remote.php/webdav/SigmaStream-Support/Production%20Open%20Issue.xlsx?downloadStartSecret=oivo2a96hjr",
#     auth=('jaypatel', '')
# )
# # print(r.status_code)
# # print(r.text)
# fname.write('r.text')
# fname.close()

import owncloud

oc = owncloud.Client('https://docs.logilite.com')

oc.login('jaypatel', '')

oc.get_file('/SigmaStream-Support/Production Open Issue.xlsx', './Issues.xlsx')

