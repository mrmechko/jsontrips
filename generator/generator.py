import re

template = """
(defmethod JONATHAN::%to-json ((variable {struct}))
  (JONATHAN::WITH-OBJECT
    {entries}
  )
)"""

entry = '(JONATHAN::WRITE-KEY-VALUE "{name}" ({getter}))'

def slot_to_name(slot):
    return slot.replace("-", "_")

def generate(struct, slots):
    entries = []
    for s in slots:
        xgetter = ""
        if ',' in s:
            s, xgetter = s.split(',')
        getter = "{}-{} variable".format(struct, s)
        if xgetter:
            getter = "{} ({})".format(xgetter, getter)
        name = slot_to_name(s)
        entries.append(entry.format(name=name, getter=getter))
    return template.format(struct=struct, entries="\n     ".join(entries))

def def_file(lines):
    buff = []
    for line in lines:
        if line.startswith(";defstruct"):
            l = line[10:].strip().split()
            buff.append(generate(l[0], l[1:]))
            buff.append("\n")
        else:
            buff.append(line)
    print("".join(buff))

def gen_from_line(line):
    line = line.split()
    return generate(line[0], line[1:])

import sys

def cmdline():
    name = sys.argv[0]
    argv = sys.argv[1:]

    if argv:
        if argv[0] == "-f":
            if len(argv) < 2:
                print("Define file name!", file=sys.stderr)
            def_file(open(argv[1]))
        elif argv[0] == "-h":
            print("usage: {} [-f filename]|[(struct description)]")
        else:
            print(generate(argv[0], argv[1:]))
    else:
        print("usage: {} [-f filename]|[(struct description)]")

if __name__=="__main__":
    cmdline()

