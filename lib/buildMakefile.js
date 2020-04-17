#!/usr/bin/env node

'use strict'

const fs = require('fs')

const [_in, _out, ...DEs] = process.argv.slice(2)

const template = String(fs.readFileSync(_in))

let iterate = false
const iteratable = []
let normal = []

template.split('\n').forEach(line => {
  if (line.endsWith('enditerate')) {
    iterate = false
  } else if (line.endsWith('beginiterate')) {
    iterate = true
  } else if (iterate) {
    iteratable.push(line)
  } else {
    normal.push(line)
  }
})

DEs.forEach(DE => {
  iteratable.forEach(line => {
    normal.push(line.replace(/\&DE/g, DE))
  })
})

normal = normal.join('\n')

fs.writeFileSync(_out, normal)
