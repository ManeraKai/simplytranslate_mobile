import os
import json


langsDirList = os.listdir("docs/lang_json/")
for item in langsDirList:

    file1 = open("docs/lang_json/"+item)
    data = file1.readlines()
    file1.close()

    data.pop(0)
    newData = []
    for row in data:
        row = '    ' + row
        newData.append(row)
    newData.insert(0, "-\n    translations = {\n")

    itemName = item.replace(".json", "")
    file2 = open("docs/lang_pug/"+itemName+".pug", "w")
    file2.writelines(newData)
    file2.close

    print("Wrote: docs/lang_pug"+item)
