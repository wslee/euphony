/* EUSolverTypes.h ---
 *
 * Filename: EUSolverTypes.h
 * Author: Abhishek Udupa
 * Created: Tue Sep 29 14:59:32 2015 (-0400)
 */

/* Copyright (c) 2015, Abhishek Udupa, University of Pennsylvania
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. All advertising materials mentioning features or use of this software
 *    must display the following acknowledgement:
 *    This product includes software developed by The University of Pennsylvania
 * 4. Neither the name of the University of Pennsylvania nor the
 *    names of its contributors may be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Code: */

#if !defined EUSOLVER_EUSOLVER_TYPES_H_
#define EUSOLVER_EUSOLVER_TYPES_H_

#ifdef __cplusplus

#include <cinttypes>
#include <cstdint>

namespace eusolver {

typedef std::uint8_t u08;
typedef std::uint16_t u16;
typedef std::uint32_t u32;
typedef std::uint64_t u64;

typedef std::int8_t i08;
typedef std::int16_t i16;
typedef std::int32_t i32;
typedef std::int64_t i64;

} /* end namespace eusolver */

#else /* ! __cplusplus */

#include <inttypes.h>
#include <stdint.h>
#include <stdbool.h>

typedef uint8_t u08;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;

typedef int8_t i08;
typedef int16_t i16;
typedef int32_t i32;
typedef int64_t i64;

#endif /* __cplusplus */

#endif /* EUSOLVER_EUSOLVER_TYPES_H_ */

/* EUSolverTypes.h ends here */
