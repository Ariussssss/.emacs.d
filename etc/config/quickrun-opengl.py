# -*- coding: utf-8 -*-
# @Author: Arius
# @Email: arius@qq.com
# @Date:   2025-06-24
import os
import sys

if __name__ == "__main__":
    _, f = sys.argv
    cmd = (
        'cd /home/arius/lib/draft/scripts/learnopengl &&  g++ -I ./include '
        + f.split('/')[-1]
        + ' ./src/glad.c -lglfw && ./a.out '
    )
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
