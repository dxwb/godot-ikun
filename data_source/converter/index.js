const keypress = () => {
  process.stdin.setRawMode(true)
  return new Promise(resolve => process.stdin.once('data', () => {
    process.stdin.setRawMode(false)
    resolve()
  }))
}

const run = async () => {
  console.log(1)
  console.log('🌟转换完成，按任意键继续')
  await keypress()
  process.exit()
}

run()
