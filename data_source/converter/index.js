const fs = require('fs')
const XLSX = require('xlsx')

const url = './data_table.xlsx'

const keypress = () => {
  process.stdin.setRawMode(true)
  return new Promise(resolve => process.stdin.once('data', () => {
    process.stdin.setRawMode(false)
    resolve()
  }))
}

const importFileString = `[remap]

importer="keep"
`

const run = async () => {
  const workbook = XLSX.readFile(url)
  workbook.SheetNames.forEach(name => {
    if (!name.includes('|')) return

    let csvString = XLSX.utils.sheet_to_csv(workbook.Sheets[name])

    csvString = csvString.replaceAll('"ID"', 'ID')

    const nameArr = name.split('|')
    const enName = nameArr[0]
    const fileName = `${enName}.csv`

    fs.writeFileSync(`./csv/${fileName}`, csvString)
    fs.writeFileSync(`./csv/${fileName}.import`, importFileString)
    console.log(`【${name}】工作表转换完成`)
  })
  console.log('🌟所有工作表都已经转换完成，按任意键继续')
  await keypress()
  process.exit()
}

run()
