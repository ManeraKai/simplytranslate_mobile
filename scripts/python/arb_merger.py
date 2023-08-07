# This script merges the arb files in `lib/l10n/langs/` and `lib/l10n/main/` to single files in `lib/l10n/`
import os
import json
import re
import yaml

langsDirList = os.listdir("lib/messages/")
for item in langsDirList:
    mainData = None
    with open(f"lib/messages/{item}") as file:
        mainData = yaml.safe_load(file)

    if item != "messages.i18n.yaml":
        with open("lib/messages/messages.i18n.yaml") as file:
            engData = yaml.safe_load(file)
            mainData['main'] = {k: v for k, v in mainData['main'].items() if k in engData['main']}
            mainData['langs'] = {k: v for k, v in mainData['langs'].items() if k in engData['langs']}

            for k, v in engData['main'].items():
                if k not in mainData['main'] or mainData['main'][k] == "":
                    mainData['main'][k] = v

            for k, v in engData['langs'].items():
                if k not in mainData['langs'] or mainData['langs'][k] == "":
                    mainData['langs'][k] = v

    with open(f'lib/messages/{item}', 'w') as file:
        yaml.dump(mainData, file, allow_unicode=True)
    print("Wrote: lib/messages/"+item)
