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
        data[key] = clean(data[key])

        if data[key] == []:
            del data[key]
        elif data[key] == {}:
            del data[key]
    return data


def main():
    if len(sys.argv) > 1:
        for fname in sys.argv[1:]:
            with open(fname) as inp:
                data = json.load(inp)
            data = clean(data)
            with open(fname, 'w') as out:
                out.write(json.dumps(data, indent=2))

if __name__ == "__main__":
    main()
