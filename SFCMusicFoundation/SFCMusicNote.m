//
//  MusicNote.m
//  MusicFoundation
//
//  Created by Enrique Zamudio Lopez on 18/07/08.
//  Copyright 2008 Desarrollo de Soluciones Abiertas, S.C.. All rights reserved.
//

#import "SFCMusicNote.h"

@interface SFCMusicNote(Privados)

- (void)fixNoteFromSharpFlat;

@end

@implementation SFCMusicNote

static unsigned short nota_semitono[13] = {
    0, 1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 6, 7
};
static short halfnotes[13] =  {
    0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0
};

+ (SFCMusicNote *)note:(unsigned short)n  octave:(unsigned short)o sharpOrFlat:(short)f {
    return [[[SFCMusicNote alloc] initWithNote:n octave:o sharpOrFlat:f] autorelease];
}

+ (SFCMusicNote *)noteWithName:(NSString *)name {
    if (!name || [name length] < 1 || [name length] > 5) {
        return nil;
    }
    char p0 = [name characterAtIndex:0];
    if (p0 < 'A' || p0 > 'G') {
        return nil;
    }
    unsigned short n = 0;
    if (p0 < 'C') {
        n = p0 - 59;
    } else {
        n = p0 - 66;
    }
    short sb = 0;
    short o = 5;
    if ([name length] > 1) {
        int pos = 1;
        p0 = [name characterAtIndex:1];
        if (p0 == '#') {
            sb = 1;
            pos = 2;
        } else if (p0 == 'b') {
            sb = -1;
            pos = 2;
        } else if (p0 < '0' || p0 > '9') {
            return nil;
        }
        if ([name length] > pos) {
            //TODO esto se puede hacer con un poco mas de codigo pero sin
            //generar substrings, hay que pensar en la memoria...
            o = [[name substringFromIndex:pos] intValue];
        }
    }
    return [self note:n octave:o sharpOrFlat:sb];
}

- initWithNote:(unsigned short)note octave:(unsigned short)octave sharpOrFlat:(short)sb {
    [super init];
    if (nota < 1 || nota > 7) {
        //TODO exception
    } else if (sb < -1 || sb > 1) {
        //TODO exception
    }
    nota = note;
    octava = octave;
    sf = sb;
    [self fixNoteFromSharpFlat];
    return self;
}

- (void)fixNoteFromSharpFlat {
    if (sf > 0) {
        if (nota == 3) {
            nota = 4;
            sf = 0;
        } else if (nota == 7) {
            nota = 1;
            if (octava == 16) {
                //TODO exception
            }
            octava++;
            sf = 0;
        }
    } else if (sf < 0) {
        if (nota == 4) {
            nota = 3;
            sf = 0;
        } else if (nota == 1) {
            if (octava == 0) {
                //TODO exception
            }
            nota = 7;
            octava--;
            sf = 0;
        }
    }
}

- (NSString *)name {
    char n[6];
    if (nota > 5) {
        n[0] = nota + 59; //A o B
    } else {
        n[0] = nota + 66; //C a G
    }
    int pos = 1;
    if (sf != 0) {
        n[1] = sf > 0 ? '#' : 'b';
        pos++;
    }
    if (octava > 10) {
        n[pos++] = (octava / 10) + 48;
        n[pos] = (octava % 10) + 48;
    } else {
        n[pos] = octava + 48;
    }
    n[pos + 1] = 0;
    return [NSString stringWithCString:n];
}

- (NSString *)nameWithoutOctave {
    char n[3];
    if (nota > 5) {
        n[0] = nota + 59; //A o B
    } else {
        n[0] = nota + 66; //C a G
    }
    int pos = 1;
    if (sf != 0) {
        n[1] = sf > 0 ? '#' : 'b';
        pos++;
    }
    n[pos] = 0;
    return [NSString stringWithCString:n];
}

//Devuelve una nueva nota igual al receptor pero una octava mas arriba
- (SFCMusicNote *)nextOctave {
    return [SFCMusicNote note:nota octave:octava + 1 sharpOrFlat:sf];
}
//Devuelve una nueva nota igual al receptor pero una octava mas abajo
- (SFCMusicNote *)prevOctave {
    if (octava > 0) {
        return [SFCMusicNote note:nota octave:octava - 1 sharpOrFlat:sf];
    }
    return nil;
}

- (unsigned short)semitone {
    int pos = 0;
    while (nota_semitono[pos++] != nota);
    return pos + sf - 1;
}

//Sube o baja la nota tantos semitonos como se indica.
- (void)transpose:(short)interval {
    //todo en variables tentativas porque al final hay que validar si no se
    //sale del rango
    unsigned short noct = octava + (interval / 12);
    short s = [self semitone] + (interval % 12);
    //NSLog(@"xp semitono %d a %d", [self semitone], s);
    if (s > 12) {
        s = (s % 12);
        noct++;
    } else if (s < 1) {
        s = 12 + (s % 12);
        noct--;
    }
    //NSLog(@"xp semitono ajustado %d", s);
    unsigned short nnot = nota_semitono[s];
    short nsf = halfnotes[s];
    if (sf < 0 && nsf > 0) {
        nsf = -nsf;
        nnot++;
        if (nnot > 7) {
            nnot = 1;
        }
    }
    //NSLog(@"xp nota nueva %d sf? %d", nnot, nsf);
    //validar nuevos valores
    if (noct > 16) {
        //TODO excepcion
    }
    nota = nnot;
    octava = noct;
    sf = nsf;
    [self fixNoteFromSharpFlat];
}

- (SFCMusicNote *)transposedNote:(short)interval {
    SFCMusicNote *n = [self copy];
    [n transpose:interval];
    if (sf != 0 && [n sharpOrFlat] != sf) {
        [n swapSharpAndFlat];
    }
    return [n autorelease];
}

- (void)swapSharpAndFlat {
    if (sf == 0) {
        return;
    }
    if (sf > 0) {
        nota++;
    } else {
        nota--;
    }
    sf = -sf;
}

- (unsigned short)note {
    return nota;
}
- (unsigned short)octave {
    return octava;
}
- (short)sharpOrFlat {
    return sf;
}

- (NSString *)description {
    return [self name];
}

- (BOOL)isEqual:(id)other {
    if ([other isKindOfClass:[SFCMusicNote class]]) {
        return ([(SFCMusicNote *)other note] == nota && [other octave] == octava && [other sharpOrFlat] == sf);
    }
    return false;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[SFCMusicNote allocWithZone:zone] initWithNote:nota octave:octava sharpOrFlat:sf];
}

@end
