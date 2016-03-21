#!/usr/bin/env python3

import os
import json



class XWalkVersion:

    def __init__(self, branch, version):
        self.__branch = branch
        self.__version = version


    def get_version(self):
        return self.__version


    def get_branch(self):
        return self.__branch


    def is_canary(self):
        last_version_num = self.__version.strip().split('.')[-1]
        return last_version_num == '0'


class ConfigLoader:

    def __init__(self):
        self.configuration = None


    def read_configuration(self, config_filename):
        if not self.configuration:
            with open(config_filename) as fp:
                self.configuration = json.load(fp)

    def get_configuration(self, key):
        return self.configuration.get(key)


    def get_deep_configuration(self, key_chains):
        pass



class XWalkDetector:

    def __init__(self):
        self.config = None
        self.arch = None
        self.xwalk = None



if __name__ == '__main__':
    config_file = "config.json"
    configloader = ConfigLoader()
    configloader.read_configuration(config_file)
    print(configloader.get_configuration('IMAGES_DIR'))
