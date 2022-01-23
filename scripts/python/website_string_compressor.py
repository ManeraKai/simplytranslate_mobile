import os
import json

enData = {}
with open("docs/lang_json/en.json") as file:
    enData = json.load(file)

for item in os.listdir("docs/lang_json/"):

    langsData = {}
    with open("docs/lang_json/"+item) as file:
        langsData = json.load(file)

    newData = {}

    for i in enData:
        if i in langsData:
            newData[i] = langsData[i]

    json_object = json.dumps(newData, ensure_ascii=False, indent=4)

    with open("docs/lang_json/"+item, "w") as outfile:
        outfile.write(json_object)
    print("Wrote: docs/lang_json/"+item)
print()