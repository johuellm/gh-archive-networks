#!/usr/bin/python
# -*- coding: utf-8 -*-



# Defaul target or output file
output_file = "output.csv"



from glob import glob
import unicodecsv as csv
import json, sys, importlib



def get_files(pattern):
  """ Get the files to extract data from.

  Args:
    pattern (str): Glob pattern for getting the files.

  Returns:
    list: A list of filenames. """
  return glob(pattern)



def process(file, writer, profile):
  """ Processes each file. Each file is a stream json object and contains one json object per line.
  Each json object is parsed and then the paths are evaluated and the data is extracted.
  Returns a concatened string.

  Args:
    file (filedescriptor): The file descriptor containing the json entries.
    writer (csv.writer): The csv writer for output.
    profile (dict): The json profile, contains two keys, first is type_filter, which is a list of event types to process.
                    Second is columns, which contains the columns paths, separated by a backslash /.

  Returns:
    None
  """
  results = []
  for line in file:
    obj = json.loads(line)

    # check type
    if obj["type"] not in profile["type_filter"]:
      continue

    # extract all selected columns
    result_entry = []
    for column in profile["columns"]:

      # split path for recursive extraction
      path = column.split("/")
      value = obj
      for p in path:
        value = value.get(p)
      result_entry.append(value)
    writer.writerow(result_entry)



def read_jsonprofile(filename):
  """ reads the jsonprofile entry . The json profile, contains two keys, first is type_filter, which is a list of event types to process.
      Second is columns, which contains the columns paths, separated by a backslash /.

    Args:
      filename (str): Filename of the jsonprofile."""
  with open(filename, "rb") as profile:
    return json.load(profile)



def print_help():
  """ Prints the help message on commandline. """
  print "Usage like: %s <jsonprofile> <glob files> [<output>]" % sys.argv[0]
  print "<jsonprofile>   - The specified profile to extract, see examples for more info."
  print "<glob files>   - glob pattern for the source files. E.g. *.json for all json files in folder."
  print "[<output.csv>] - optional, output file, defaults to output.csv."



if __name__ == "__main__":
  """ Main run of the extraction"""

  # check command line (TODO, use argparse)
  if len(sys.argv) > 1 and sys.argv[1].lower() in ("-h","help","-help","--help"):
    print_help()
    sys.exit(0)

  if len(sys.argv) < 3:
    print_help()
    sys.exit(1)

  # import profile page (TODO, maybe use correct configuration files in the future)
  profile = read_jsonprofile(sys.argv[1])

  # get list of all files
  files = get_files(sys.argv[2])

  # set output file
  if len(sys.argv) == 4:
    output_file = sys.argv[4]

  # create output file
  with open(output_file, 'wb') as output:
    
    writer = csv.writer(output)

    # create header
    writer.writerow(profile["columns"])

    # iterate over files and append to output stream
    for filename in files:
      with open(filename, 'r') as file:
        process(file, writer, profile)
