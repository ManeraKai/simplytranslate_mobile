# this file converts translated json files in `docs/lang_json` to pug files in `docs/lang_pug` for the website
import os
import json


for item in os.listdir("docs/lang_json/"):
    itemName = item.replace(".json", "")

    enDataJson = {}
    with open("docs/lang_json/en.json") as file:
        enDataJson = json.load(file)

    langDataJson = {}
    with open("docs/lang_json/"+item) as file:
        langDataJson = json.load(file)

    dict3 = {**enDataJson, **langDataJson}

    print(dict3)

    if dict3 != {}:

        enLangsData = {}
        with open("lib/l10n/langs/intl_en.arb") as file:
            enLangsData = json.load(file)

        langsData = {}
        with open("lib/l10n/langs/intl_"+itemName+".arb") as file:
            langsData = json.load(file)

        allLangsData = {**enLangsData, **langsData}

        dict3.update(allLangsData)

        newJson = {}
        for i in dict3:
            if not i.startswith("@"):
                newJson[i] = dict3[i]

        # Take missing strings from main.arb
        enData = {}
        with open("lib/l10n/main/intl_en.arb") as file:
            enData = json.load(file)
        newJson.update(enData)

        mainData = {}
        with open("lib/l10n/main/intl_"+itemName+".arb") as file:
            mainData = json.load(file)
        newJson.update(mainData)
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
print()
