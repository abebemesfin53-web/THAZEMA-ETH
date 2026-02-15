# 🔧 SPECIAL FEATURES INTEGRATION GUIDE

## Quick Start Guide to Add New Features to Thazema

This guide shows you exactly how to integrate all the new special features into your existing Thazema app.

---

## 📋 TABLE OF CONTENTS

1. [Dark Mode Toggle](#1-dark-mode-toggle)
2. [Voice Messages](#2-voice-messages)
3. [Message Reactions](#3-message-reactions)
4. [Live Location Sharing](#4-live-location-sharing)
5. [Disappearing Messages](#5-disappearing-messages)
6. [Message Scheduling](#6-message-scheduling)
7. [AI Smart Reply](#7-ai-smart-reply)

---

## 1. 🌙 DARK MODE TOGGLE

### Add to Navigation Bar

**File**: `client/src/pages/Dashboard.js`

```javascript
// Add import at top
import DarkModeToggle from '../components/DarkModeToggle';

// Add to your navigation/header section
<div className="dashboard-header">
  <h1>Thazema</h1>
  <DarkModeToggle />
</div>
```

### That's it! Dark mode is now active! 🎉

---

## 2. 🎤 VOICE MESSAGES

### Add to Chat Input Area

**File**: `client/src/components/ChatWindow.js` (or similar)

```javascript
// Add imports
import { useState } from 'react';
import VoiceMessage from './VoiceMessage';
import { FaMicrophone } from 'react-icons/fa';

// Add state
const [showVoiceRecorder, setShowVoiceRecorder] = useState(false);

// Add button next to text input
<div className="chat-input">
  <button 
    className="btn-voice"
    onClick={() => setShowVoiceRecorder(true)}
  >
    <FaMicrophone />
  </button>
  <input type="text" placeholder="Type a message..." />
  <button className="btn-send">Send</button>
</div>

// Add voice recorder modal
{showVoiceRecorder && (
  <VoiceMessage
    onSend={(audioData) => {
      // Send voice message
      sendVoiceMessage(audioData);
      setShowVoiceRecorder(false);
    }}
    onCancel={() => setShowVoiceRecorder(false)}
  />
)}

// Add send function
const sendVoiceMessage = (audioData) => {
  // TODO: Upload audio to server
  console.log('Voice message:', audioData);
  // Add to messages
  setMessages([...messages, {
    type: 'voice',
    audioURL: audioData.audioURL,
    duration: audioData.duration,
    sender: currentUser,
    timestamp: new Date()
  }]);
};
```

---

## 3. ❤️ MESSAGE REACTIONS

### Add to Each Message

**File**: `client/src/components/ChatWindow.js`

```javascript
// Add import
import MessageReactions from './MessageReactions';

// In your message rendering
{messages.map(message => (
  <div key={message.id} className="message">
    <p>{message.text}</p>
    
    {/* Add reactions component */}
    <MessageReactions
      messageId={message.id}
      reactions={message.reactions || {}}
      onReact={(msgId, emoji) => handleReaction(msgId, emoji)}
    />
  </div>
))}

// Add reaction handler
const handleReaction = (messageId, emoji) => {
  // TODO: Send to server
  socket.emit('message:react', {
    messageId,
    emoji,
    userId: currentUser.id
  });
  
  // Update local state
  setMessages(messages.map(msg => {
    if (msg.id === messageId) {
      const reactions = { ...msg.reactions };
      if (!reactions[emoji]) reactions[emoji] = [];
      
      // Toggle reaction
      const userIndex = reactions[emoji].indexOf(currentUser.username);
      if (userIndex > -1) {
        reactions[emoji].splice(userIndex, 1);
      } else {
        reactions[emoji].push(currentUser.username);
      }
      
      return { ...msg, reactions };
    }
    return msg;
  }));
};
```

---

## 4. 📍 LIVE LOCATION SHARING

### Add to Chat Options Menu

**File**: `client/src/components/ChatWindow.js`

```javascript
// Add imports
import { useState } from 'react';
import LiveLocation from './LiveLocation';
import { FaMapMarkerAlt } from 'react-icons/fa';

// Add state
const [showLocationSharing, setShowLocationSharing] = useState(false);

// Add button in chat options
<button 
  className="btn-location"
  onClick={() => setShowLocationSharing(true)}
>
  <FaMapMarkerAlt /> Share Location
</button>

// Add location sharing modal
{showLocationSharing && (
  <div className="modal-overlay">
    <LiveLocation
      onShare={(location) => {
        // Send location update
        socket.emit('location:share', {
          chatId: currentChat.id,
          location
        });
      }}
      onStop={() => {
        socket.emit('location:stop', { chatId: currentChat.id });
        setShowLocationSharing(false);
      }}
    />
  </div>
)}
```

---

## 5. ⏳ DISAPPEARING MESSAGES

### Add to Chat Settings

**File**: `client/src/components/ChatSettings.js`

```javascript
// Add import
import DisappearingMessages from './DisappearingMessages';

// In chat settings panel
<div className="chat-settings">
  <h3>Chat Settings</h3>
  
  <DisappearingMessages
    currentSetting={currentChat.disappearingSetting || 'off'}
    onSet={(setting) => {
      // Update chat settings
      socket.emit('chat:update-disappearing', {
        chatId: currentChat.id,
        setting
      });
      
      // Update local state
      setCurrentChat({
        ...currentChat,
        disappearingSetting: setting
      });
    }}
  />
</div>
```

---

## 6. ⏰ MESSAGE SCHEDULING

### Add to Message Input

**File**: `client/src/components/ChatWindow.js`

```javascript
// Add imports
import { useState } from 'react';
import MessageScheduler from './MessageScheduler';
import { FaClock } from 'react-icons/fa';

// Add state
const [showScheduler, setShowScheduler] = useState(false);
const [messageToSchedule, setMessageToSchedule] = useState('');

// Add schedule button
<div className="chat-input">
  <input 
    type="text" 
    value={messageText}
    onChange={(e) => setMessageText(e.target.value)}
    placeholder="Type a message..." 
  />
  <button 
    className="btn-schedule"
    onClick={() => {
      if (messageText.trim()) {
        setMessageToSchedule(messageText);
        setShowScheduler(true);
      }
    }}
  >
    <FaClock />
  </button>
  <button className="btn-send" onClick={sendMessage}>
    Send
  </button>
</div>

// Add scheduler modal
{showScheduler && (
  <MessageScheduler
    message={messageToSchedule}
    onSchedule={(data) => {
      // Send scheduled message to server
      socket.emit('message:schedule', {
        chatId: currentChat.id,
        message: data.message,
        scheduledTime: data.scheduledTime
      });
      
      setShowScheduler(false);
      setMessageText('');
      setMessageToSchedule('');
      
      alert('Message scheduled successfully!');
    }}
    onCancel={() => {
      setShowScheduler(false);
      setMessageToSchedule('');
    }}
  />
)}
```

---

## 7. 🤖 AI SMART REPLY

### Add Below Chat Input

**File**: `client/src/components/ChatWindow.js`

```javascript
// Add import
import SmartReply from './SmartReply';

// Get last message from other person
const lastReceivedMessage = messages
  .filter(m => m.sender !== currentUser.id)
  .slice(-1)[0];

// Add below chat input
<div className="chat-input-area">
  {/* Smart Reply Suggestions */}
  {lastReceivedMessage && (
    <SmartReply
      lastMessage={lastReceivedMessage.text}
      onSelect={(suggestion) => {
        // Send the suggested reply
        sendMessage(suggestion);
      }}
    />
  )}
  
  {/* Regular chat input */}
  <div className="chat-input">
    <input type="text" placeholder="Type a message..." />
    <button className="btn-send">Send</button>
  </div>
</div>
```

---

## 🎨 STYLING TIPS

### Add to your main CSS file:

```css
/* Modal Overlay */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10000;
}

/* Button Styles */
.btn-voice, .btn-location, .btn-schedule {
  background: transparent;
  border: none;
  color: #0ea5e9;
  font-size: 20px;
  cursor: pointer;
  padding: 8px;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.btn-voice:hover, .btn-location:hover, .btn-schedule:hover {
  background: rgba(14, 165, 233, 0.1);
  transform: scale(1.1);
}
```

---

## 🔌 BACKEND INTEGRATION

### Socket.io Events to Add

**File**: `server/index.js` (or your socket handler)

```javascript
// Voice Messages
socket.on('message:voice', async (data) => {
  // Save voice message to database
  const message = await Message.create({
    type: 'voice',
    audioURL: data.audioURL,
    duration: data.duration,
    sender: socket.userId,
    chat: data.chatId
  });
  
  // Broadcast to chat
  io.to(data.chatId).emit('message:new', message);
});

// Reactions
socket.on('message:react', async (data) => {
  // Update message reactions
  const message = await Message.findByIdAndUpdate(
    data.messageId,
    { $push: { [`reactions.${data.emoji}`]: data.userId } },
    { new: true }
  );
  
  // Broadcast update
  io.to(message.chat).emit('message:updated', message);
});

// Live Location
socket.on('location:share', (data) => {
  // Broadcast location to chat
  io.to(data.chatId).emit('location:update', {
    userId: socket.userId,
    location: data.location
  });
});

socket.on('location:stop', (data) => {
  // Stop sharing
  io.to(data.chatId).emit('location:stopped', {
    userId: socket.userId
  });
});

// Disappearing Messages
socket.on('chat:update-disappearing', async (data) => {
  // Update chat settings
  await Chat.findByIdAndUpdate(data.chatId, {
    disappearingSetting: data.setting
  });
  
  // Broadcast to chat
  io.to(data.chatId).emit('chat:settings-updated', {
    disappearingSetting: data.setting
  });
});

// Scheduled Messages
socket.on('message:schedule', async (data) => {
  // Save scheduled message
  const scheduled = await ScheduledMessage.create({
    message: data.message,
    scheduledTime: data.scheduledTime,
    sender: socket.userId,
    chat: data.chatId
  });
  
  // Set up timer to send
  const delay = new Date(data.scheduledTime) - new Date();
  setTimeout(async () => {
    const message = await Message.create({
      text: scheduled.message,
      sender: scheduled.sender,
      chat: scheduled.chat
    });
    io.to(scheduled.chat).emit('message:new', message);
    await scheduled.remove();
  }, delay);
});
```

---

## 📦 DATABASE MODELS

### Update Message Model

```javascript
const messageSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ['text', 'voice', 'image', 'video', 'location'],
    default: 'text'
  },
  text: String,
  audioURL: String,
  duration: Number,
  reactions: {
    type: Map,
    of: [String], // Array of user IDs
    default: {}
  },
  sender: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  },
  chat: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Chat'
  },
  expiresAt: Date, // For disappearing messages
  createdAt: {
    type: Date,
    default: Date.now
  }
});

// Auto-delete expired messages
messageSchema.index({ expiresAt: 1 }, { expireAfterSeconds: 0 });
```

### Add Chat Settings

```javascript
const chatSchema = new mongoose.Schema({
  participants: [{
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User'
  }],
  disappearingSetting: {
    type: String,
    enum: ['off', '24h', '7d', '90d'],
    default: 'off'
  },
  // ... other fields
});
```

### Add Scheduled Messages Model

```javascript
const scheduledMessageSchema = new mongoose.Schema({
  message: {
    type: String,
    required: true
  },
  scheduledTime: {
    type: Date,
    required: true
  },
  sender: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  chat: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Chat',
    required: true
  },
  status: {
    type: String,
    enum: ['pending', 'sent', 'cancelled'],
    default: 'pending'
  }
});
```

---

## ✅ TESTING CHECKLIST

After integration, test each feature:

- [ ] Dark mode toggles correctly
- [ ] Voice messages record and play
- [ ] Reactions add and remove
- [ ] Live location shares and updates
- [ ] Disappearing messages setting saves
- [ ] Messages schedule correctly
- [ ] Smart replies suggest appropriately
- [ ] All features work on mobile
- [ ] Dark mode applies to all features
- [ ] No console errors

---

## 🚀 QUICK START

### Minimal Integration (5 minutes):

1. **Add Dark Mode** to navigation
2. **Add Smart Reply** to chat input
3. **Test** both features
4. **Rebuild APK**

### Full Integration (30 minutes):

1. Add all 7 features
2. Update backend socket events
3. Update database models
4. Test everything
5. Rebuild APK

---

## 📞 NEED HELP?

**Administrator**: Abebe Mesfin  
**Phone**: +251 914 319 514  
**Email**: abebemesfin53@gmail.com

---

## 🎉 YOU'RE DONE!

Once integrated, your Thazema app will have all the special features!

**Rebuild your APK and enjoy!** 🚀

```bash
cd "websyit project"
.\REBUILD_MOBILE_APK.bat
```

---

**Happy Coding!** 💻✨
