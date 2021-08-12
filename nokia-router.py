import sys
import zlib
import struct
import binascii


if (len(sys.argv) < 3):

    print('usage:')
    print('%s -u config.cfg [-o config.xml]' % sys.argv[0])
    print('%s -p config.xml [-o config.cfg]' % sys.argv[0])

    exit()


if (sys.argv[1] == '-u'):

    out_filename = "config.xml"
    if (len(sys.argv) == 5 and sys.argv[3] == '-o'):
        out_filename = sys.argv[4]

    cf = open(sys.argv[2], 'rb')
    of = open(out_filename, 'wb')

    # read the header
    header = cf.read(0x14)

    # check the magic
    if (header[0:4] != '\x00\x12\x31\x23' or header[0x10:0x14] != '\x42\x14\xC1\x23'):
        print('invalid magic')
        exit()

    # read the size of the compressed data
    data_size = struct.unpack('>I', header[4:8])[0]

    # read the compressed data
    compressed = cf.read(data_size)

    # read the checksum of the compressed data
    checksum = struct.unpack('>I', header[8:12])[0]

    # verify the checksum
    if (binascii.crc32(compressed) & 0xFFFFFFFF != checksum):
        print('invalid crc32')
        exit()

    # unpack the config
    xml_data = zlib.decompress(compressed)

    # output the xml file
    of.write(xml_data)

    of.close()
    cf.close()


elif (sys.argv[1] == '-p'):

    out_filename = "config_out.cfg"
    if (len(sys.argv) == 5 and sys.argv[3] == '-o'):
        out_filename = sys.argv[4]

    xf = open(sys.argv[2], 'rb')
    of = open(out_filename, 'wb')

    # read the xml file
    xml_data = xf.read()

    # compress using default zlib compression
    compressed = zlib.compress(xml_data)

    ## write the header ##
    # magic1
    of.write('\x00\x12\x31\x23')
    # size of compressed data
    of.write(struct.pack('>I', len(compressed)))
    # crc32 checksum
    of.write(struct.pack('>I', binascii.crc32(compressed) & 0xFFFFFFFF))
    # size of xml file
    of.write(struct.pack('>I', len(xml_data) + 1))
    # magic2
    of.write('\x42\x14\xC1\x23')

    # write the compressed data
    of.write(compressed)

    of.close()
    xf.close()
