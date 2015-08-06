#!/usr/bin/env python

#   Description:
#       This script will get the weekly merge pull request information between
#       the last week and this week and then sort it by username.
#   Author:
#       Zhong, Qiu <zhongx.qiu@intel.com>
#   Modified:
#

import sys
import time
import subprocess
import argparse


class WeeklyPR(object):

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
        self.pr_dict = {}


    def get_week_log(self):
        cmd = ['git', 'log', '%s..%s' % (self.last_commit_id, self.this_commit_id)]

        try:
            git_p = subprocess.Popen(cmd,
                             stdout = subprocess.PIPE,
                             stderr = subprocess.STDOUT,
                             cwd = self.dest_dir,
                             shell = False)

            grep_p = subprocess.Popen(['grep', 'Merge pull request'],
                                      stdin = git_p.stdout,
                                      stdout = subprocess.PIPE,
                                      stderr = subprocess.STDOUT,
                                      shell = False)
            self.weekly_info = grep_p.stdout.read()

        except Exception as e:
            print(e)
            sys.stderr.write('Exception raised when executing command %s' %
                            cmd)
            self.weekly_info = None

        return self.weekly_info


    def sort_weekly_info(self):
        for line in self.weekly_info.strip().split('\n'):
            splitted_line = line.strip().split()
            committer = splitted_line[-1].split('/')[0]
            if not committer in self.pr_dict:
                self.pr_dict[committer] = [line.strip()]
            else:
                self.pr_dict[committer].append(line.strip())

        for (key, value) in self.pr_dict.items():
            value.sort()

        sorted_pr = sorted(self.pr_dict.items(),
                           key = lambda item: len(item[1]),
                           reverse = True)

        for pr in sorted_pr:
            for log in pr[1]:
                print(log)
            print('')


def main():
    last_commit_id = 'WW31_Release_ID'
    this_commit_id = 'WW32_Release_ID'
    cts_dir = '/home/orange/00_jiajia/work_space/release/crosswalk-test-suite'

    parser = argparse.ArgumentParser(description = 'Get the merge pull request records between two commit ID')
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
            pr = WeeklyPR(args.last_commit_id, args.this_commit_id, cts_dir, commit_file= True)
        else:
            last_commit_id_file = 'WW%02d_Release_ID' % int(time.strftime("%W"))
            this_commit_id_file = 'WW%02d_Release_ID' % (int(time.strftime('%W')) + 1)

            pr = WeeklyPR(last_commit_id_file, this_commit_id_file, cts_dir, commit_file = True)
    else:
        if args.last_commit_id and args.this_commit_id:
            pr = WeeklyPR(last_commit_id, this_commit_id, cts_dir)

    pr.get_week_log()
    pr.sort_weekly_info()


if __name__ == '__main__':
    main()