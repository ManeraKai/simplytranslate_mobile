# This script merges the arb files in `lib/l10n/langs/` and `lib/l10n/main/` to single files in `lib/l10n/`

import os
import json


langsDirList = os.listdir("lib/l10n/langs/")
for item in langsDirList:

    langsFile = open("lib/l10n/langs/"+item)

    langsFileData = json.load(langsFile)
    langsFile.close()

    mainFile = open("lib/l10n/main/"+item)
    mainFileData = json.load(mainFile)
    # mainFileData = mainFileData.decode("UTF16")
    mainFile.close()

    finalData = langsFileData.copy()
    finalData.update(mainFileData)
    finalData
    json_object = json.dumps(finalData, ensure_ascii=False, indent=4)
    with open("lib/l10n/"+item, "w") as outfile:
        outfile.write(json_object)
    print("Wrote: lib/l10n/"+item)
