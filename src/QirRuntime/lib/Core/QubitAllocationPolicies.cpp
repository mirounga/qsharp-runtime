#include <assert.h>

#include "QubitAllocationPolicies.hpp"

namespace quantum
{
    long CReuseLastReleasedQubitAllocationPolicy::AcquireId()
    {
        long id = -1;
        if (!this->released.empty())
        {
            id = this->released.top();
            released.pop();
            assert(!this->used.IsBitSetAt(id));
        }
        else
        {
            id = ++this->lastUsedId;
            used.ExtendToInclude(id);
        }
        this->used.SetBitAt(id);
        return id;
    }

    void CReuseLastReleasedQubitAllocationPolicy::ReleaseId(long id)
    {
        assert(this->used.IsBitSetAt(id));
        this->used.FlipBitAt(id);
        this->released.push(id);

        // TODO: check if the tail between this id and lastUsedId
        // consists of released ids and reset lastUsedId instead of
        // growing the stack
    }
} // namespace quantum