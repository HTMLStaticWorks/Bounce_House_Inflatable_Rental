const fs = require('fs');
const path = require('path');

const dir = __dirname;
const indexHtml = fs.readFileSync(path.join(dir, 'index.html'), 'utf8');

// Extract the footer from index.html
const footerRegex = /<!-- Footer -->\s*<footer>[\s\S]*?<\/footer>/i;
const match = indexHtml.match(footerRegex);

if (!match) {
    console.error("Could not find footer in index.html");
    process.exit(1);
}

const targetFooter = match[0];
console.log("Found footer, length:", targetFooter.length);

const files = fs.readdirSync(dir).filter(f => f.endsWith('.html'));

let updatedCount = 0;

for (const file of files) {
    if (file === 'index.html' || file === 'login.html' || file === 'signup.html') {
        continue;
    }
    
    let content = fs.readFileSync(path.join(dir, file), 'utf8');
    
    if (footerRegex.test(content)) {
        content = content.replace(footerRegex, targetFooter);
        fs.writeFileSync(path.join(dir, file), content, 'utf8');
        console.log(`Updated footer in ${file}`);
        updatedCount++;
    } else {
        console.log(`No footer found in ${file}`);
    }
}

console.log(`Done. Updated ${updatedCount} files.`);
