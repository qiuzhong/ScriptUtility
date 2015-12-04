# -*- coding:utf-8 -*-

# -*- coding:utf-8 -*-

import os
import shutil


XWALK_DIR = r"C:\xwalk"
CROSSWALK_VERSION = "17.46.443.0"
APPTOOLS_DIR = os.path.join(XWALK_DIR, 'release', 'apptools')
ZIP_DIR = os.path.join(APPTOOLS_DIR, CROSSWALK_VERSION)
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
			os.system('python %s -t msi' % os.path.join(XWALK_DIR,
						'crosswalk-test-suite', 'tools', 'build', 'pack_windows.py'))
			os.system('mv *.zip %s' % ZIP_DIR)


if __name__ == '__main__':
	xwalk_win_list = 'apptools_windows_list'
	if check_test_suite(xwalk_win_list):
		pack_test_suites(xwalk_win_list)

