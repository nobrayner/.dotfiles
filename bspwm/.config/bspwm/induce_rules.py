import sys
import json

source = open(sys.argv[1]) if len(sys.argv) > 1 else sys.stdin
state = json.load(source)

def print_rules(prefix, node, path):
    if node is None:
        return
    elif node['client'] is None:
        print_rules(prefix, node['firstChild'], path+['1'])
        print_rules(prefix, node['secondChild'], path+['2'])
    else:
        client = node['client']
        print('bspc rule -a {}:{} -o node={}{}'.format(client['className'],
                                                       client['instanceName'],
                                                       prefix, '/'.join(path)))

for i, monitor in enumerate(state['monitors']):
    for j, desktop in enumerate(monitor['desktops']):
        print_rules('@^{}:^{}:/'.format(i+1, j+1), desktop['root'], [])
