import argparse
# >python3 update_supplicant.py -i test_input -s test_supplicant_file


def parse_line(_line):
    equal_index = _line.find('=')
    _key = _line[:equal_index].strip()
    _value = _line[equal_index + 1:].strip().strip("\"")
    return _key, _value


def update_supplicant(_new_network, _all_networks):
    updated = False
    for key, value in enumerate(_all_networks):
        if value['ssid'] == _new_network['ssid']:
            _all_networks[key] = _new_network
            updated = True
    if not updated:
        _all_networks.append(_new_network)
    return _all_networks


def write_new_supplicant(_supplicant_file, _header, _all_networks):
    with open(_supplicant_file, 'w') as f:
        f.write(_header)
        for network in _all_networks:
            f.write('network={\n')
            f.write(f'\tssid="{network["ssid"]}"\n')
            if 'psk' in network:
                f.write(f'\tpsk="{network["psk"]}"\n')
                f.write('\tkey_mgmt=WPA-PSK\n')
            else:
                f.write('\tkey_mgmt=NONE\n')
            f.write('}\n')


parser = argparse.ArgumentParser()
parser.add_argument("-i", help="input file")
parser.add_argument("-s", help="supplicant file")
args = parser.parse_args()
input_file = args.i
supplicant_file = args.s

input_network = {}
with open(input_file) as f:
    for line in f:
        key, value = parse_line(line)
        input_network[key] = value

all_networks = []
header = ''
with open(supplicant_file) as f:
    is_header = True
    network = {}
    for line in f:
        if is_header:
            if not str(line).startswith('network'):
                header += line
            else:
                is_header = False
        else:
            if not str(line).startswith('network') and not str(line).startswith('}'):
                key, value = parse_line(line)
                network[key] = value
            elif str(line).startswith('}'):
                all_networks.append(network)
                network = {}

all_networks = update_supplicant(input_network, all_networks)
write_new_supplicant(supplicant_file, header, all_networks)

print(f'updated {supplicant_file} from {input_file} .. or not')
