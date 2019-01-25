import json
import pprint
import sys


def clean(data):
    if type(data) is list:
        nd = []
        for d in data:
            d = clean(d)
            if d:
                nd.append(d)
        return nd
    elif type(data) is not dict:
        return data
    keys = list(data.keys())
    for key in keys:
        if key == "type" and data[key] and data[key][0] == "?":
            # delete the variable name and rename type to typeq if it is a 'one of'
            typeq = data[key][2:]
            del data[key]
            key = "typeq"
            data[key] = typeq
        data[key] = clean(data[key])

        if data[key] == []:
            del data[key]
        elif data[key] == {}:
            del data[key]
    return data

def clean_lex_entry(entry, word_entries):
    if not entry:
        return []
    cat, label, val = entry
    if cat == "NONE":
        cat = None
    name = val["name"]
    if not val["name"]:
        name = val["word"]+val["pos"]+str(len(word_entries))
    word_entries[name] = val
    return {"cat": cat, "name": label, "entry": name}

def clean_lexicon(lex):
    #TODO: sort the keys so that updates don't take a ton of space.
    word_entries = {}
    return {
        "words": {k: [clean_lex_entry(e, word_entries) for e in v] for k, v in lex.items()},
        "entries": word_entries
    }

def main():
    if len(sys.argv) > 1:
        for fname in sys.argv[1:]:
            with open(fname) as inp:
                data = json.load(inp)
            if fname == "dist/words.json":
                data = clean_lexicon(data)
            data = clean(data)
            with open(fname, 'w') as out:
                out.write(json.dumps(data, indent=2, sort_keys=True))

if __name__ == "__main__":
    main()
