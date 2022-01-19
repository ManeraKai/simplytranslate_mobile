# this file converts translated json files in `docs/lang_json` to pug files in `docs/lang_pug` for the website

import os
import json

langsDirList = os.listdir("docs/lang_json/")
for item in langsDirList:
    itemName = item.replace(".json", "")
    file1 = open("docs/lang_json/"+item)
    dataJson = json.load(file1)
    file1.close()

    langsFile = open("lib/l10n/langs/intl_"+itemName+".arb")
    langsData = json.load(langsFile)
    langsFile.close()

    dataJson.update(langsData)

    newJson = {}
    for i in dataJson:
        if not i.startswith("@"):
            newJson[i] = dataJson[i]

    data = json.dumps(newJson, ensure_ascii=False, indent=4).split('\n')

    for i in range(0, len(data)):
        data[i] += "\n"

    data.pop(0)
    newData = []
    for row in data:
        row = '    ' + row
        newData.append(row)
    newData.insert(0, "-\n    translations = {\n")

    file2 = open("docs/lang_pug/"+itemName+".pug", "w")
    file2.writelines(newData)
    file2.close

    print("Wrote: docs/lang_pug/"+itemName+".pug")
