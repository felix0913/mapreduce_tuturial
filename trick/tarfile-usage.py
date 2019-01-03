import tarfile


tar = tarfile.open('w.tar.gz', 'r:gz')
for i in tar.getmembers():
    f = tar.extractfile(i)
    if f is not None:
        content = f.read()
        print(content)