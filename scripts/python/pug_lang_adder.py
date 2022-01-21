# This script sees the available translations and create pug pages for them.
import os
import json

rtl_langs = ["ar", "iw", "ku", "fa", "ur"]

template = ""
with open("docs/pug/lang/en.pug") as file:
    template = file.read()

for item in os.listdir("docs/lang_pug/"):
    itemName = item.replace(".pug", "")
    tmp = template.replace("\"en\"", "\""+itemName+"\"")
    tmp = tmp.replace("en.pug", item)

    if itemName in rtl_langs:
        tmp = tmp.replace("\"ltr\"", "\"rtl\"")
        tmp = tmp.replace("- var isRtl = false", "- var isRtl = true")

    with open("docs/pug/lang/"+item, "w") as file:
        file.writelines(tmp)

    print("Wrote: docs/pug/lang/"+item)
print()