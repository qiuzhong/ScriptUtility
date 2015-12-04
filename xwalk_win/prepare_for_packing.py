import os
import sys
import json
import shutil

def update_code(root_dir):
	os.chdir(root_dir)
	os.system('git reset --hard HEAD')
	os.system('git pull')


def download_xwalk_sdk(http_proxy, sdk_bin_dir):
	url_file = 'xwalk_for_windows_url.txt'
	sdk_url = None
	with open(url_file) as f:
		sdk_url = f.read().strip().split('\n')[-1]
		print(sdk_url)
		
	os.chdir(sdk_bin_dir)
	if sdk_url:
		print('curl -x %s -O %s' % (http_proxy, sdk_url))
		os.system('curl %s' % (sdk_url))


def copy_sdk(cts_dir, sdk_bin_dir, xwalk_version):
	src_sdk_path = os.path.join(sdk_bin_dir, 'crosswalk-%s.zip' % xwalk_version)
	dest_sdk_path = os.path.join(cts_dir, 'tools', 'crosswalk-%s.zip' % xwalk_version)
	os.chdir(os.path.dirname(dest_sdk_path))
	os.system('rm -fv *.zip')
	if not os.path.exists(dest_sdk_path):
		shutil.copy(src_sdk_path, dest_sdk_path)


def update_xwalk_version(cts_dir, xwalk_version):
	VERSION = os.path.join(cts_dir, 'VERSION')
	with open(VERSION, 'rb') as f:
		data = json.load(f, encoding = 'utf-8')
    	data['main-version'] = xwalk_version
	
	with open(VERSION, 'wb') as f:
		json.dump(data, f, encoding = 'utf-8', indent = 4)


def copy_icon(cts_dir, src_dir):
	src_icon = os.path.join(src_dir, 'icon.ico')
	webapi_dir = os.path.join(cts_dir, 'webapi')
	print(src_icon)
	if os.path.exists(src_icon):
		print('%s does exist!' % src_icon)

		webapi_tc = os.listdir(webapi_dir)
		for tc in webapi_tc:
			dest_icon = os.path.join(cts_dir, 'webapi', tc, 'icon.ico')
			if not os.path.exists(dest_icon):
				print('%s -> %s' % (src_icon, dest_icon))
				shutil.copy(src_icon, dest_icon)
			else:
				print('%s already exists!' % dest_icon)


def update_xwalk_app_tools():
	# Use the crosswalk-app-tools latest version as it's stable
	# Do not use the crosswalk-app-tools on github
	os.system('npm update crosswalk-app-tools -g --verbose')


if __name__ == '__main__':
	cts_dir = r"C:\xwalk\crosswalk-test-suite"
	sdk_bin_dir = r"C:\xwalk\release\crosswalk_binary"
	http_proxy = 'child-prc.intel.com:913'
	xwalk_ver_file = 'xwalk_version.txt'

	try:
		with open(xwalk_ver_file) as f:
			xwalk_version = f.read().strip()
	except IOError as e:
		print('Failed to open file %s' % xwalk_ver_file)
		sys.exit(1)

	# update_xwalk_app_tools()
	# update_code(cts_dir)
	# update_xwalk_version(cts_dir, xwalk_version)
	# download_xwalk_sdk(http_proxy, sdk_bin_dir)
	# copy_sdk(cts_dir, sdk_bin_dir, xwalk_version)
	


	