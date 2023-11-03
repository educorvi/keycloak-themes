#!/usr/bin/env node
const fs = require('fs');
const path = require('path')
const execSync = require('child_process').execSync;
const archiver = require('archiver')

const baseDir = __dirname;

const themes = process.argv.slice(2);

let addedNew = true;

let themePropertyFiles = []

while (addedNew) {
    addedNew = false;
    for (const theme of themes) {
        let internalThemes;
        try {
            internalThemes = fs.readdirSync(path.join(baseDir, theme), {withFileTypes: true})
                .filter(dir => dir.isDirectory() && dir.name !== 'dist')
                .map(dir => path.join(dir.path, dir.name, 'theme.properties'));
        } catch (e) {
            console.error(`Could not read theme "${theme}"`)
            process.exit(-1);
        }
        themePropertyFiles = themePropertyFiles.concat(internalThemes)
    }
    for (const themePropertyFile of themePropertyFiles) {
        const data = fs.readFileSync(themePropertyFile).toString();
        const dependencies = data.split("\n")
            .filter(line => line.startsWith("parent="))
            .map(line => line.replace("parent=", ""))
            .map(line => line.split(" "))
            .flat()
            .filter(dep => dep !== "base");
        for (const dependency of dependencies) {
            if (themes.indexOf(dependency) === -1) {
                themes.push(dependency);
                addedNew = true;
                console.info("Adding dependency " + dependency);
            }
        }
    }
}
console.info("---------------------------------------------------------\nBuilding themes " + themes.join(", ") + "\n---------------------------------------------------------");

console.info("(Re)Creating fresh dist folder...")
const distDir = path.join(baseDir, "dist");
fs.rmSync(distDir, {recursive: true, force: true});
fs.mkdirSync(distDir);

for (const theme of themes) {
    console.info(`Building "${theme}"...`)
    try {
        const out = execSync("make dist", {cwd: path.join(baseDir, theme), windowsHide: true});
    } catch (e){
        console.error("Error building " + theme);
        process.exit(-1)
    }
    fs.cpSync(path.join(baseDir, theme, 'dist'), path.join(distDir, theme), {recursive: true});
}
console.info("Creating zipfile...")
const output = fs.createWriteStream(path.join(baseDir, 'dist.zip'))
const archive = archiver('zip', {});
output.on('close', function() {
    console.log('dist.zip created');
});

archive.on('warning', function(err) {
    if (err.code === 'ENOENT') {
        // log warning
        console.warn(err);
    } else {
        // throw error
        throw err;
    }
});

archive.on('error', function(err) {
    throw err;
});

archive.pipe(output);

archive.directory(path.join(distDir), false);
archive.finalize();