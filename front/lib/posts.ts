import fs from "fs";
import path from "path";

const postsDirectory = path.join(process.cwd(), "data");

type PostItem = {
  id: string;
  json: any[]
};

export function getSortedPostsData() {
  // Get file names under /posts
  const fileNames = fs.readdirSync(postsDirectory).reverse();
  const allPostsData = fileNames.map((fileName) => {
    // Remove ".md" from file name to get id
    const id = fileName.replace(/\.md$/, "");

    // Read markdown file as string
    const fullPath = path.join(postsDirectory, fileName);
    const fileContents = fs.readFileSync(fullPath, "utf8");
    const json = JSON.parse(fileContents);
    // Combine the data with the id
    return {
      id,
      json
    } as PostItem;
  });

  return allPostsData
}