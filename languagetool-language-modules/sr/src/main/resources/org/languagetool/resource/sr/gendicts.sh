#!/usr/bin/env bash

# This script contains command for quick POS dictionary and SYNTH_ dictionary generation.
# Shell scripts (or rather, symbolic links to "ltshell") are generated by RPM module.

# Adjust as needed
CORPUS_FILE=/opt/app/s/smd/lt/serbian-corpus.txt
CORPUS_HUNSPELL_FILE=/opt/app/s/smd/lt/hunspell-serbian-corpus.txt
TEMPDIR=/tmp
FREQFILE=serbian-wordlist.xml

if [ ! -f ${CORPUS_FILE} ]; then
    echo "Serbian word corpus file ${CORPUS_FILE} does not exist, aborting ..."
    exit 1
fi

echo "Generating POS Serbian dictionary ..."
ltposdic -i ${CORPUS_FILE} -info serbian.info -freq ${FREQFILE} -o serbian.dict

echo "Generating SYNTH Serbian dictionary ..."
ltsyndic -i ${CORPUS_FILE} -info serbian_synth.info -o serbian_synth.dict

echo "Generating HunSpell dictionary ..."
ltspldic -i ${CORPUS_HUNSPELL_FILE} -info hunspell/sr_RS.info -freq ${FREQFILE} -o hunspell/sr_RS.dict

# It was observed that process leaves temporary files in /tmp directory
# so we will clean up after ourselves
echo -n "Cleaning up ... "
rm -f ${TEMPDIR}/DictionaryBuilder*txt ${TEMPDIR}/DictionaryBuilder*info \
      ${TEMPDIR}/SynthDictionaryBuilder*txt ${TEMPDIR}/SynthDictionaryBuilder*info \
      ${TEMPDIR}/SpellDictionaryBuilder*txt ${TEMPDIR}/SpellDictionaryBuilder*info
#rm      ${FREQFILE}
echo "done."