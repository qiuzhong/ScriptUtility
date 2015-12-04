# -*- coding:utf-8 -*-

import os
import sys
import glob
import shutil


PWD = r"C:\xwalk\release"
XWALK_DIR = r"C:\xwalk"
CROSSWALK_VERSION = None
xwalk_ver_file = 'xwalk_version.txt'
try:
	with open(xwalk_ver_file) as f:
		CROSSWALK_VERSION = f.read().strip()
except IOError as e:
	print('Failed to open file %s' % xwalk_ver_file)
	sys.exit(1)

MASTER_DIR = os.path.join(PWD, 'master')
ZIP_DIR = os.path.join(MASTER_DIR, CROSSWALK_VERSION)

if not os.path.exists(ZIP_DIR):
	os.system('mkdir %s' % ZIP_DIR)

def check_test_suite(test_suite_list):	
	global XWALK_DIR
	with open(test_suite_list) as f:
		for line in f:
			if not line.strip():
				continue
			abs_test_suite_path = os.path.join(XWALK_DIR, \
				"crosswalk-test-suite", line.strip()).replace('\\', '/')
			if not os.path.exists(abs_test_suite_path):
				print('%s does not exist!' % abs_test_suite_path)
				return False
	return True			


def pack_test_suites(test_suite_list):
	global XWALK_DIR
	global ZIP_DIR
	test_suites = []
	with open(test_suite_list) as f:
		for line in f:
			if not line.strip():
				continue
			abs_test_suite_path = os.path.join(XWALK_DIR, \
				"crosswalk-test-suite", line.strip()).replace('\\', '/')
			os.chdir(abs_test_suite_path)
			tc_name = line.strip().split('/')[-1]
			# print(ZIP_DIR)
			abs_zip_path = os.path.join(ZIP_DIR, '%s-%s-1.msi.zip' % (tc_name, CROSSWALK_VERSION))
			# print(abs_zip_path)
			# break
			if not os.path.exists(abs_zip_path):
				print('not exist!')
				os.system('python %s -t msi' % os.path.join(XWALK_DIR,
						'crosswalk-test-suite', 'tools', 'build', 'pack_windows.py'))
				if glob.glob('*.zip'):
					os.system('mv *.zip %s' % ZIP_DIR)

			else:
				print('%s already exists!' % (abs_zip_path))
				with open(os.path.join(PWD, 'fail_tc.txt'), 'w+') as fail_obj:
					fail_obj.write(line)



if __name__ == '__main__':
	xwalk_win_list = 'xwalk_windows_list'
	if check_test_suite(xwalk_win_list):
		pack_test_suites(xwalk_win_list)

	