meta:
  id: hccap
  title: Hashcat capture file (old version)
  license: Unlicense
  file-extension: hccap
  application:
    - Hashcat
    - aircrack-ng
  endian: le
  encoding: utf-8
doc: |
  Native format of Hashcat password "recovery" utility.

  A sample of file for testing can be downloaded from https://web.archive.org/web/20150220013635if_/http://hashcat.net:80/misc/example_hashes/hashcat.hccap
doc-ref: https://hashcat.net/wiki/doku.php?id=hccap
seq:
  - id: records
    type: hccap_record
    repeat: eos
types:
  hccap_record:
    seq:
      - id: essid
        size: 36
      - id: ap_mac
        size: 6
        doc: The BSSID (MAC address) of the access point
      - id: station_mac
        size: 6
        doc: The MAC address of a client connecting to the access point
      - id: station_nonce
        size: 32
      - id: ap_nonce
        size: 32
      - id: eapol_buffer
        type: eapol_dummy
        size: 256
        doc: Buffer for EAPOL data, only first `len_eapol` bytes are used
      - id: len_eapol
        -orig-id: eapol_size
        type: u4
        doc: Size of EAPOL data
      - id: keyver
        type: u4
        doc: |
          The flag used to distinguish WPA from WPA2 ciphers. Value of
          1 means WPA, other - WPA2.
      - id: keymic
        size: 16
        doc: |
          The final hash value. MD5 for WPA and SHA-1 for WPA2
          (truncated to 128 bit).
    instances:
      eapol:
        io: eapol_buffer._io
        pos: 0
        size: len_eapol
  eapol_dummy: {}
