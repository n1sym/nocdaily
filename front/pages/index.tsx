import Link from 'next/link'
import { getSortedPostsData } from "../lib/posts";
import { GetStaticProps } from "next";

type PostItem = {
  id: string;
  json: any[]
};

export default function Home({
  allPostsData
}: {
  allPostsData: PostItem[],
}) {
  return (
    <div>
      <main>
        {Object.keys(allPostsData).map((key: any) => {
          return <>
            <h3>{allPostsData[key].id}</h3>
            {Object.keys(allPostsData[key].json).map((key2: any) => {
              return <>
                <Link href={`${allPostsData[key].json[key2].url}`} target="_blank" rel="noopener" id="link">
                  <h4>{allPostsData[key].json[key2].title}</h4>
                </Link>
                <p id="header">{allPostsData[key].json[key2].state} / {allPostsData[key].json[key2].counts}</p>
                <div id="desc">{allPostsData[key].json[key2].desc}</div>
              </>
            })}
          </>
        })}
      </main>
    </div>
  )
}

export const getStaticProps: GetStaticProps = async () => {
  const allPostsData = getSortedPostsData();
  return {
    props: {
      allPostsData,
    },
  };
};