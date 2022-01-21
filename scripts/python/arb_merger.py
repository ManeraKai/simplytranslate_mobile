# This script merges the arb files in `lib/l10n/langs/` and `lib/l10n/main/` to single files in `lib/l10n/`
import os
import json


langsDirList = os.listdir("lib/l10n/langs/")
for item in langsDirList:

    langsData = ""
    with open("lib/l10n/langs/"+item) as file:
        langsData = json.load(file)

    mainData = ""
    with open("lib/l10n/main/"+item) as file:
        mainData = json.load(file)

    finalData = langsData.copy()
    finalData.update(mainData)

    json_object = json.dumps(finalData, ensure_ascii=False, indent=4)

    with open("lib/l10n/"+item, "w") as outfile:
        outfile.write(json_object)
    print("Wrote: lib/l10n/"+item)
print()