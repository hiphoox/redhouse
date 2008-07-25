//
//  MusicScale.m
//  MusicFoundation
//
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import "SFCMusicScale.h"


@implementation SFCMusicScale

+ (SFCMusicScale *)majorScaleFromNote:(SFCMusicNote *)base {
    return [[[SFCMusicScale alloc] initWithType:0 baseNote:base] autorelease];
}

+ (SFCMusicScale *)minorNaturalScaleFromNote:(SFCMusicNote *)base {
    return [[[SFCMusicScale alloc] initWithType:1 baseNote:base] autorelease];
}

+ (SFCMusicScale *)minorHarmonicScaleFromNote:(SFCMusicNote *)base {
    return [[[SFCMusicScale alloc] initWithType:2 baseNote:base] autorelease];
}

+ (SFCMusicScale *)minorMelodicScaleFromNote:(SFCMusicNote *)base {
    return [[[SFCMusicScale alloc] initWithType:3 baseNote:base] autorelease];
}

//Una pentatonica es una menor con solamente 5 notas
+ (SFCMusicScale *)pentatonicScaleFromNote:(SFCMusicNote *)base {
    return [[[SFCMusicScale alloc] initWithType:4 baseNote:base] autorelease];
}

- initWithType:(unsigned short)aType baseNote:(SFCMusicNote *)note {
    [super init];
    type = aType;
    fund = [note retain];
    NSMutableArray *notas = [[NSMutableArray alloc] initWithCapacity:7];
    [notas addObject:fund];
    if (type == 0) { //mayor
        SFCMusicNote *n = [fund transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:1];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
    } else if (type >= 1 && type <= 3) { //menores
        SFCMusicNote *n = [fund transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:1];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        if (type == 1) { //natural
            n = [n transposedNote:1];
            [notas addObject:n];
            n = [n transposedNote:2];
            [notas addObject:n];
        } else if (type == 2) { //armonica
            n = [n transposedNote:1];
            [notas addObject:n];
            n = [n transposedNote:3];
            [notas addObject:n];
        } else if (type == 3) { //melodica
            n = [n transposedNote:2];
            [notas addObject:n];
            n = [n transposedNote:2];
            [notas addObject:n];
        }
    } else if (type == 4) { //pentatonica
        SFCMusicNote *n = [fund transposedNote:3];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:2];
        [notas addObject:n];
        n = [n transposedNote:3];
        [notas addObject:n];
    }
    NSEnumerator *e = [notas objectEnumerator];
    SFCMusicNote *n;
    if ([fund sharpOrFlat] == 0) {
        SFCMusicNote *p = nil;
        BOOL swap = false;
        //Revisar si hay que cambiar sostenidos por bemoles
        //esto es cuando se repiten notas (ej. G, G# realmente deben ser G, Ab)
        while ((n = [e nextObject]) != nil && !swap) {
            if (p && [[p nameWithoutOctave] characterAtIndex:0] == [[n nameWithoutOctave] characterAtIndex:0]) {
                swap = YES;
            }
            p = n;
        }
        if (swap) {
            e = [notas objectEnumerator];
            while ((n = [e nextObject]) != nil) {
                if ([n sharpOrFlat] != 0) {
                    [n swapSharpAndFlat];
                }
            }
        }
    } else {
        //cambiar las notas que tengan alteracion distinta de la
        //fundamental por sus enarmonicos.
        while ((n = [e nextObject]) != nil) {
            if ([n sharpOrFlat] != 0 && [n sharpOrFlat] != [fund sharpOrFlat]) {
                [n swapSharpAndFlat];
            }
        }
    }
    notes = notas;
    return self;
}

- (NSArray *)notes {
    return notes;
}

- (SFCMusicNote *)baseNote {
    return fund;
}

- (SFCMusicScale *)relativeScale {
    SFCMusicScale *rel = nil;
    if (type == 0) {
        //devolver la menor relativa (natural)
        rel = [SFCMusicScale minorNaturalScaleFromNote:[fund transposedNote:-3]];
    } else {
        //devolver la mayor relativa
        rel = [SFCMusicScale majorScaleFromNote:[fund transposedNote:3]];
    }
    return rel;
}

- (SFCMusicScale *)nextUpperScale {
    if (type != 0) {
        return nil;
    }
    SFCMusicNote *sig = [notes objectAtIndex:4];
    if ([sig sharpOrFlat] == -1) {
        [sig swapSharpAndFlat];
    }
    return [SFCMusicScale majorScaleFromNote:sig];
}

- (SFCMusicScale *)nextLowerScale {
    if (type != 0) {
        return nil;
    }
    SFCMusicNote *sig = [notes objectAtIndex:3];
    if ([sig sharpOrFlat] == 1) {
        [sig swapSharpAndFlat];
    }
    return [SFCMusicScale majorScaleFromNote:sig];
}

- (unsigned short)intervalOfNote:(SFCMusicNote *)note {
    for (int i = 0; i < [notes count]; i++) {
        SFCMusicNote *o = [notes objectAtIndex:i];
        if ([note note] == [o note] && [note sharpOrFlat] == [o sharpOrFlat]) {
            return i + 1;
        }
    }
    return 0;
}

- (SFCMusicNote *)noteAtInterval:(short)interval {
    return [self noteAtInterval:interval fromInterval:1];
}

- (SFCMusicNote *)noteAtInterval:(short)interval fromInterval:(unsigned short)ref {
    if (interval == 0 || ref == 0) {
        return nil;
    }
    ref %= 7;
    short i2 = 0;
    short octs = 0;
    SFCMusicNote *n = nil;
    if (interval > 0) {
        i2 = ref + interval - 2;
        n = [notes objectAtIndex:i2 % 7];
        octs = i2 / 7;
    } else {
        i2 = ref + interval;
        octs = i2 / 7;
        if (i2 < 0) {
            octs--;
            while (i2 < -6) i2 += 7;
            i2 = 7 - i2;
        }
        n = [notes objectAtIndex:i2];
    }
    if (octs != 0) {
        n = [n transposedNote:12 * octs];
    }
    return n;
}

- (short)intervalBetweenNote:(SFCMusicNote *)n1 andNote:(SFCMusicNote *)n2 {
    short i1 = [self intervalOfNote:n1];
    short i2 = [self intervalOfNote:n2];
    if (i1 == 0 || i2 == 0) {
        return 0;
    }
    i1 = i2 - i1;
    if (i1 >= 0) {
        i1++;
    } else {
        i1--;
    }
    return i2;
}

- (NSString *)description {
    NSString *t = @"major";
    if (type == 1) {
        t = @"minor natural";
    } else if (type == 2) {
        t = @"minor harmonic";
    } else if (type == 3) {
        t = @"minor melodic";
    } else if (type == 4) {
        t = @"minor pentatonic";
    }
    return [NSString stringWithFormat:@"%@ %@", [fund nameWithoutOctave], t];
}

- (void)dealloc {
    [fund release];
    [notes release];
    [super dealloc];
}

@end
