const { exec } = require('pkg')

const build = async () => {
  await exec(['index.js', '-t', 'win', '-o', '../converter.exe'])
  console.log('🌟excel转换器打包完成！')
}

build()
