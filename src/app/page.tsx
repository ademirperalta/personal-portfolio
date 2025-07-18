import Link from "next/link";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center p-24">
      <Link href="/gif" className="group">
        <h1 className="text-7xl font-bold text-center">Ademir Peralta</h1>
      </Link>
    </main>
  );
}
