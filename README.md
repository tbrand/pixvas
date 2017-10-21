# Pixvas

<h1 align="center">
    <img src="https://user-images.githubusercontent.com/3483230/31853739-c2c08dd6-b6c8-11e7-94c1-8592118b0516.png" width="200"/>
</h1>

<p align="center">
	Create pixel image in your terminal, the concept inspired by <a href="https://github.com/sebashwa/vixl44">vixl44</a>
</p>

## Gallery

### ..Sword?
<img src="https://user-images.githubusercontent.com/3483230/31853792-dd1227de-b6c9-11e7-8ad0-e3542bc1d23d.gif" width="180"/>

## Installation

### Requirements
 - [Crystal](https://github.com/crystal-lang/crystal)

```
> shards build
> ./bin/pixvas # Executable binary
```

## Usage

### Command options
```
  --width=WIDTH   --- Set canvas width (-w for short)
  --height=HEIGHT --- Set canvs height (-h for short)
  --dot=DOT_WIDTH --- Set dot width (-d for short)
```

### Key bindings
```
  <Space>    --- Print the color
  p, n, f, b --- Move cursor: UP, DOWN, FORWARD, BACK
  c          --- Change color
  d          --- Delete the dot
  g          --- Set background color
  <Ctl-c>    --- Quit
```

## Development
- [ ] Export the image
- [ ] Save work
- [ ] Install via brew

## Contributing

1. Fork it ( https://github.com/tbrand/pixvas/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tbrand](https://github.com/tbrand) Taichiro Suzuki - creator, maintainer
