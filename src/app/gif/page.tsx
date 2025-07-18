"use client";
import Image from "next/image";
import { useEffect } from "react";
import { useRouter } from "next/navigation";

export default function GifPage() {
  const router = useRouter();

  useEffect(() => {
    const id = setTimeout(() => {
      router.back();
    }, 3000);

    return () => clearTimeout(id);
  }, [router]);

  return (
    <main className="flex min-h-screen flex-col space-between items-center justify-center  bg-black">
      {}
      <Image
        src="/chopper.gif"
        alt="Chopper!"
        className="w-96 h-auto rounded-lg shadow-lg"
        width={500}
        height={300}
      />
      <Image
        src="/matcha.gif"
        alt="matcha!"
        className="w-96 h-auto rounded-lg shadow-lg"
        width={500}
        height={300}
      />
    </main>
  );
}
