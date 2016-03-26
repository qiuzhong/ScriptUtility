# -*- coding: utf8 -*-

'''Find the missing test suite that do not be packaged successfully
So we can pack it manually.'''

import os

def get_xwalk_version():
	version = None

	with open('xwalk_version.txt') as f:
		version = f.read().strip();

	return version


def find_missing_tc(xwalk_version, package_dir, tc_list_file):
	'''Compare the test suites in package_dir and list in tc_list_file'''
	zip_files = os.listdir(package_dir)	
	tc_in_package = [zip_file.replace('-{version}-1.msi.zip'.format(version = xwalk_version), '')
					for zip_file in zip_files]
	tc_in_package_set = set(tc_in_package)
	# print(len(tc_in_package_set))
	# for tc in sorted(tc_in_package_set):
	# 	print(tc)

	data = None
	with open(tc_list_file) as f:
		data = f.read()

	if not data:
		sys.stderr.write("No test suite list found in file {tc_list_file}!".format(
						tc_list_file = tc_list_file))
		sys.exit(1)

	lines = data.strip().split('\n')
	tc_in_file = [line.strip().split('/')[-1] for line in lines]
	tc_in_file_set = set(tc_in_file)
	# print(len(tc_in_file_set))
	# for tc in sorted(tc_in_file_set):
	# 	print(tc)

	tc_missing = tc_in_file_set - tc_in_package_set
	for tc in sorted(tc_missing):
		print(tc_missing)


if __name__ == '__main__':
	prefix_dir = r'C:\xwalk\release\master'
	xwalk_version = get_xwalk_version()
	package_dir = os.path.join(prefix_dir, xwalk_version)
	tc_list_file = os.path.join(os.getcwd(), 'xwalk_windows_list')

	find_missing_tc(xwalk_version, package_dir, tc_list_file)