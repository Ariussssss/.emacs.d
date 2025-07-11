# -*- coding: utf-8 -*-
# @Author: Arius
# @Email: arius@qq.com
# @Date:   2025-06-24
import os
import sys

if __name__ == "__main__":
    _, f = sys.argv
    cmd = f'cd {os.path.dirname(f)}/.. && python -m ' + '.'.join(f.split('/')[-2:])
    print(sys.argv)
    print(cmd)
    os.system(cmd)
    # if len(sys.argv) > 1:
    #     func = sys.argv[1]
    #     props = ', '.join([f"'{p}'" for p in sys.argv[2:] if p])
    #     cmd = f"{func}({props})"
    #     eval(cmd)
    # else:
    #     main()
