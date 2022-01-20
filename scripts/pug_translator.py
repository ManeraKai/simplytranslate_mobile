# this file converts translated json files in `docs/lang_json` to pug files in `docs/lang_pug` for the website
import os
import json


for item in os.listdir("docs/lang_json/"):
    itemName = item.replace(".json", "")

    dataJson = {}
    with open("docs/lang_json/"+item) as file:
        dataJson = json.load(file)

    langsData = {}
    with open("lib/l10n/langs/intl_"+itemName+".arb") as file:
        langsData = json.load(file)

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

    with open("docs/lang_pug/"+itemName+".pug", "w") as file:
        file.writelines(newData)

    print("Wrote: docs/lang_pug/"+itemName+".pug")
