# find command tool usage
find is a powerful tool to find the files with specific characteristics.
## How to find all the zip files and print them in current directory and its subdirectories recursively?

```Bash
find . -name '*.zip' -print
```

## How to find all the zip files and remove them in current directory and its subdirectories recursively?

```Bash
find . -name '*.zip' -exec rm {} \;
```

## How to remove the .git directory in current directory and its subdirectories recursively?

```Bash
find . -name '.git' | xargs rm -fr
```
