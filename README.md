当我执行`go mod tidy`会报错, 因为此时, 我的 d1 还没有提交到 github.com

```bash

D:\source\go\gowork2\d2>go mod tidy
go: finding module for package github.com/relax-space/gowork2/d1
go: downloading github.com/relax-space/gowork2 v0.0.0-20250709024340-04445a9c4e32
go: github.com/relax-space/gowork2/d2 imports
        github.com/relax-space/gowork2/d1: module github.com/relax-space/gowork2@latest found (v0.0.0-20250709024340-04445a9c4e32), but does not contain package github.com/relax-space/gowork2/d1

D:\source\go\gowork2\d2>go run main.go
main.go:6:2: no required module provides package github.com/relax-space/gowork2/d1; to add it:
        go get github.com/relax-space/gowork2/d1

```

现在加入 go.work 之后,虽然`go mod tidy`还是报错,但是可以正常获得结果了

```bash

D:\source\go\gowork2\d2>go mod tidy
go: finding module for package github.com/relax-space/gowork2/d1
go: github.com/relax-space/gowork2/d2 imports
        github.com/relax-space/gowork2/d1: module github.com/relax-space/gowork2@latest found (v0.0.0-20250709024340-04445a9c4e32), but does not contain package github.com/relax-space/gowork2/d1

D:\source\go\gowork2\d2>go run main.go
结果是3
```

当我创建标签,并提交后, 要等一段时间,等标签同步到代理服务器,然后,就可以`go mod tidy`了

```
git tag d1/v0.1.0
git push origin d1/v0.1.0
```

```
D:\source\go\gowork2\d2>go mod tidy
go: finding module for package github.com/relax-space/gowork2/d1
go: downloading github.com/relax-space/gowork2 v0.0.0-20250709083354-fdded287bb44
go: downloading github.com/relax-space/gowork2/d1 v0.1.0
go: found github.com/relax-space/gowork2/d1 in github.com/relax-space/gowork2/d1 v0.1.0

```

因为版本会代理服务器缓存了,无法删除, 所以我打算创建一个 d3 来做测试(没有版本的)


