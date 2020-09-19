#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void gris_ASM(uint8_t* imgRGB, short n, uint8_t* imgGray);

void gris_C(uint8_t* imgRGB, short n, uint8_t* imgGray)
{
	uint8_t colorR, colorG, colorB;
	uint16_t colorGray;
	int imgSize, nPixel, nColor;

	imgSize = n*n;

	for(nPixel = 0; nPixel < imgSize; ++nPixel)
	{
		nColor = 3*nPixel;

		colorR = imgRGB[nColor + 0];
		colorG = imgRGB[nColor + 1];
		colorB = imgRGB[nColor + 2];

		colorGray = (colorR + 2*colorG + colorB);
		colorGray = colorGray / 4;

		imgGray[nPixel] = colorGray;
	}
}

int main(void)
{
	uint8_t imgRGB[2*2*3] = {0, 0, 0, 1, 1, 1, 51, 50, 53, 255, 255, 255};
	uint8_t imgGray_C[2*2*1];
	uint8_t imgGray_ASM[2*2*1];

	printf("Yo : %d, %d, %d, %d\r\n", 0, 1, 51, 255);

	gris_C(imgRGB, 2, imgGray_C);
	printf("C  : %d, %d, %d, %d\r\n", imgGray_C[0], imgGray_C[1], imgGray_C[2], imgGray_C[3]);

	gris_ASM(imgRGB, 2, imgGray_ASM);
	printf("ASM: %d, %d, %d, %d\r\n", imgGray_ASM[0], imgGray_ASM[1], imgGray_ASM[2], imgGray_ASM[3]);

	return EXIT_SUCCESS;
}
