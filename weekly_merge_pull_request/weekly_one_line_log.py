#!/usr/bin/env python

#   Description:
#       This script will get the weekly commit titles between
#       the last week and this week and then sort it by username.
#   Author:
#       Zhong, Qiu <zhongx.qiu@intel.com>
#   Modified:
#

import sys
import time
import subprocess
import argparse

class WeeklyCommitTitle(object):
    def __init__(self, last_commit_id, this_commit_id, dest_dir, commit_file = False):
        # If input is not the commit id file
        if not commit_file:

            self.last_commit_id = last_commit_id
            self.this_commit_id = this_commit_id
        else:
            self.last_commit_id = open(last_commit_id).read().strip()
            self.this_commit_id = open(this_commit_id).read().strip()

        self.weekly_info = None
        self.dest_dir = dest_dir
        

    def get_week_log(self):
        cmd = ['git', 'log', '--pretty=oneline', '%s..%s' % (self.last_commit_id, self.this_commit_id)]
        print(cmd)
        try:
            git_p = subprocess.Popen(cmd,
                             stdout = subprocess.PIPE,
                             stderr = subprocess.STDOUT,
                             cwd = self.dest_dir,
                             shell = False)

            self.weekly_info = git_p.stdout.read()

        except Exception as e:
            print(e)
            sys.stderr.write('Exception raised when executing command %s' %
                            cmd)
            self.weekly_info = None

        return self.weekly_info    


    def write_weekly_titles(self):
        '''Get the commit titles and write them to a text file.'''
        
        lines = self.weekly_info.strip().split('\n')
        titles = [line[41:] for line in lines]

        with open('weekly_commit_titles.txt', 'w') as f:
            for title in titles:
                f.write(title + '\n')


def main():
    cts_dir = '/home/orange/00_jiajia/work_space/release/crosswalk-test-suite'

    parser = argparse.ArgumentParser(description = 'Get the commit titles between two commit ID')
    parser.add_argument('-l', '--last_commit_id', type = str,
                        help = 'The commit ID of last week frozen status.')
    parser.add_argument('-t', '--this_commit_id', type = str,
                        help = 'The commit ID of this week frozen status.')
    parser.add_argument('-f', '--isfile', action = 'store_true',
                        help = 'Specify whether the commit ID is stored in the file.')
    args = parser.parse_args()

    pr = None
    if args.isfile:
        if args.last_commit_id and args.this_commit_id:
            pr = WeeklyCommitTitle(args.last_commit_id, args.this_commit_id, cts_dir, commit_file = True)
        else:
            last_commit_id_file = 'WW%02d_Release_ID' % int(time.strftime("%W"))
            this_commit_id_file = 'WW%02d_Release_ID' % (int(time.strftime('%W')) + 1)

            pr = WeeklyCommitTitle(last_commit_id_file, this_commit_id_file, cts_dir, commit_file = True)
    else:
        if args.last_commit_id and args.this_commit_id:
            pr = WeeklyCommitTitle(last_commit_id, this_commit_id, cts_dir)

    if pr:
        pr.get_week_log()
        pr.write_weekly_titles()


if __name__ == '__main__':
    main()
