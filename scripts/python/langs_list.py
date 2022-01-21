# This script creates a list of available languages in json.
import os
import json

lang_list = []
for item in os.listdir("docs/lang_json/"):
    item_name = item.replace(".json", "")
    lang_list.append(item_name)

# json_object = json.dumps(lang_list, ensure_ascii=False, indent=4)
with open("docs/langs_list.js", "w") as file:
    file.writelines("const langs_list = "+str(lang_list))

print(lang_list)
print("Wrote: docs/langs_list.js")
print()