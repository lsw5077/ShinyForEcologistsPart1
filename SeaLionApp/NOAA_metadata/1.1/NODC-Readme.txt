This is the standard package for a National Oceanographic Data Center (NODC)
data archival information package (also called an 'accession').  Each
accession maintained by NODC is given a unique integer identifier known as
an 'accession id'.  All information related to that accession is contained
within a directory using the accession id as the directory name.  The
accession directory has the following standard structure:

<accession id>/<major version>.<minor version>: This directory.
         Contains the information for the revision of this accession
         numbered <major version>.<minor version>.  Major version revisions
         indicate that the data providers' data, located within the 'data'
         directory, have been updated.  Minor version revisions indicate
         that the NODC generated metafiles located within the 'about'
         directory have been updated.  Initial versions of accessions that
         contain data providers' digital data begin with version 1.1.
         Initial versions of accessions that contain only NODC metafiles
         begin with version 0.1.

  NODC-Readme.txt: This file.

  about: Directory.  Contains NODC-authored accession-related metadata and
         provenance information (e.g., email exchanged between NODC and the
         data provider) including but not limited to the following standard
         file:

    journal.txt: A text file that contains any notes, NODC processing actions,
         etc., relating to this accession.

  data: Directory.  Archival data and metadata files from the data provider
         are located in the 'data' directory.

    0-data: A directory containing the data provider's data unmodified from
         its initial digital format as submitted to NODC.  The initial
         source for these data should be documented in the header of the
         <accession id>/<major version>.<minor version>/about/journal.txt
         file after the 'Source' keyword.

    1-data: An optional directory which may contain a processed or otherwise
         translated version of the data provider's data which may have been
         unzipped, uncompressed, untarred, or otherwise extracted or
         modified.  A note should be found in the file
         <accession id>/<major version>.<minor version>/about/journal.txt
         explaining how files in 1-data were derived from the files in 0-data.

<accession id>/<accession id>.<major version>.<minor version>.xml:
         A text file containing directory and cryptographic digest
         information for all files in this version of the accession (except
         for that of the <accession id>.<major version>.<minor version>.xml
         file itself).

For additional information specific to this NODC archival information
package, see:
         ./about/journal.txt
