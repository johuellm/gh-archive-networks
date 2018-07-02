#!/usr/bin/python
# -*- coding: utf-8 -*-



import unicodecsv as csv
import sys



def get_logins(row):
  """ Returns the set of login names from a row object. """

  # all columns, which contain a login
  name_columns = [2,6,7,8,10,11,12,13,14,16,17,19,20]

  # TODO: special case for column 9 as it is formatted as list

  # get values from column indicdes
  names = set([row[i].strip() for i in name_columns if row[i].strip()])

  # remove the the source if duplicate is available (no self-loops)
  names.remove(row[2])

  return names



if __name__ == "__main__":
  """ Main run of the parse split"""

  # get input filename
  input_file = sys.argv[1]

  # set output file
  output_file = input_file + ".parsed.csv"

  result = []
  projections = [{},{},{},{},{},{}] # page_name, issueid, commentid, pullrequestreviewid, commitid, pullrequestid

  # parse input file
  with open(input_file, 'rb') as csvinput:
    
    entry_index = 1

    reader = csv.reader(csvinput)
    reader.next() # skip header
    for row in reader:

      # Create multiple entries if available
      base_entry = [entry_index, row[3], row[0], row[1], row[2]] # autoincrement_id, repo, type, time, source, target
      for target in get_logins(row):
        result.append(base_entry + [target])
        entry_index = entry_index + 1

      # Create projections for conversations (issues,forks, and identify users participating in the same conversation)
      projection_index = 0
      for column_index in [21,22,24,25,26,28]:   # page_name, issueid, commentid, pullrequestreviewid, commitid, pullrequestid
        if row[column_index].strip():
          if row[column_index] in projections[projection_index]:
            projections[projection_index][row[column_index]].append(row)
          else:
            projections[projection_index][row[column_index]] = [row,]
        projection_index = projection_index + 1

  # project key, values
  for projection in projections:
    for key, rows in projection.iteritems():
      previous_authors = set()   # edges are only drawn to previous commenters in a conversation
      for row in rows:
        base_entry = [entry_index, row[3], row[0], row[1], row[2]] # autoincrement_id, repo, type, time, source, target
        for prev_author in previous_authors:  # edges to all previous commenters in the thread
          if prev_author != row[2]:   # skip self-loops
            result.append(base_entry + [prev_author])
            entry_index = entry_index + 1
        previous_authors.add(row[2])


  # remove 1-1 duplicates which might arise
  set(map(tuple,result))

  # dump result
  with open(output_file, 'wb') as csvoutput:
    
    writer = csv.writer(csvoutput)

    # create header
    writer.writerow(["id","repo","type","time","source","target"])

    for entry in result:
      writer.writerow(entry)
